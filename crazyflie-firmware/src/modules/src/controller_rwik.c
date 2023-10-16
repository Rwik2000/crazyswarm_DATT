#include <math.h>

#include "param.h"
#include "log.h"
#include "math3d.h"
#include "position_controller.h"
#include "controller_rwik.h"
#include "physicalConstants.h"

static float g_vehicleMass = CF_MASS;
static float massThrust = 132000;

// XY Position PID
// static float kp_xy = 0.0;       // P
// static float kd_xy = 0.0;       // D
// static float ki_xy = 0.00;      // I
// static float i_range_xy = 0.0;

// Z Position
// static float kp_z = 0.0;        // P
// static float kd_z = 0.0;        // D
// static float ki_z = 0.0;        // I
// static float i_range_z  = 0.0;

// Attitude
// static float kR_xy = 0.0; // P
static float kw_xy = 20000; // D
// static float ki_m_xy = 0.0; // I
// static float i_range_m_xy = 1.0;

// Yaw
// static float kR_z = 0.0; // P
static float kw_z = 12000; // D
static float ki_w_z = 10000; // Integral term for the angular velocity controller.
static float ki_w_x = 5000;
static float ki_w_y = 5000;

static float i_range_roll = 10;
static float i_range_pitch = 10;
static float i_range_yaw = 10;
// static float i_range_m_z  = 0.0;

// roll and pitch angular velocity
static float kd_omega_rp = 200; // D


// Helper variables
static float i_error_x = 0;
static float i_error_y = 0;
static float i_error_z = 0;

static float i_error_omega_roll = 0;
static float i_error_omega_pitch = 0;
static float i_error_omega_yaw = 0;

static float prev_omega_roll;
static float prev_omega_pitch;
static float prev_setpoint_omega_roll;
static float prev_setpoint_omega_pitch;

// static float i_error_m_x = 0;
// static float i_error_m_y = 0;
// static float i_error_m_z = 0;

// Logging variables
static struct vec z_axis_desired;

static float cmd_thrust;
static float cmd_roll;
static float cmd_pitch;
static float cmd_yaw;
static float r_roll;
static float r_pitch;
static float r_yaw;
static float accelz;

static float cmd_z_acc;

static float angVel_x;
static float angVel_y;
static float angVel_z;

static float state_x;
static float state_y;
static float state_z;


static float quat_x;
static float quat_y;
static float quat_z;
static float quat_w;

static float ref_x;
static float ref_y;
static float ref_z;

static float rot_des_x;
static float rot_des_y;
static float rot_des_z;

static float i_roll;
static float i_pitch;
static float i_yaw;


void controllerRwikReset(void)
{
  i_error_x = 0;
  i_error_y = 0;
  i_error_z = 0;
  i_error_omega_roll = 0;
  i_error_omega_pitch = 0;
  i_error_omega_yaw = 0;
  // i_error_m_x = 0;
  // i_error_m_y = 0;
  // i_error_m_z = 0;
}

void controllerRwikInit(void)
{
  controllerRwikReset();
}

bool controllerRwikTest(void)
{
  return true;
}

void controllerRwik(control_t *control, setpoint_t *setpoint,
                                         const sensorData_t *sensors,
                                         const state_t *state,
                                         const uint32_t tick)
{
  // struct vec r_error;
  // struct vec v_error;
  // struct vec target_thrust;
  // struct vec z_axis;
  float current_thrust;
  // float ew_z_integral;
  // struct vec x_axis_desired;
  // struct vec y_axis_desired;
  // struct vec x_c_des;
  struct vec ew, M;
  float dt;
  // float desiredYaw = 0; //deg

  if (!RATE_DO_EXECUTE(ATTITUDE_RATE, tick)) {
    return;
  }

  dt = (float)(1.0f/ATTITUDE_RATE);
  ////////////////////////////////////////////////
  // struct vec setpointPos = mkvec(setpoint->position.x, setpoint->position.y, setpoint->position.z);
  // struct vec setpointVel = mkvec(setpoint->velocity.x, setpoint->velocity.y, setpoint->velocity.z);
  // struct vec statePos = mkvec(state->position.x, state->position.y, state->position.z);
  // struct vec stateVel = mkvec(state->velocity.x, state->velocity.y, state->velocity.z);

  // Position Error (ep)
  // r_error = vsub(setpointPos, statePos);

  // Velocity Error (ev)
  // v_error = vsub(setpointVel, stateVel);

  // Integral Error
  // i_error_z += r_error.z * dt;
  // i_error_z = clamp(i_error_z, -i_range_z, i_range_z);
// 
  // i_error_x += r_error.x * dt;
  // i_error_x = clamp(i_error_x, -i_range_xy, i_range_xy);
// 
  // i_error_y += r_error.y * dt;
  // i_error_y = clamp(i_error_y, -i_range_xy, i_range_xy);

  // Desired thrust [F_des]
  // if (setpoint->mode.x == modeAbs) {
    // target_thrust.x = g_vehicleMass * setpoint->acceleration.x                       + kp_xy * r_error.x + kd_xy * v_error.x + ki_xy * i_error_x;
    // target_thrust.y = g_vehicleMass * setpoint->acceleration.y                       + kp_xy * r_error.y + kd_xy * v_error.y + ki_xy * i_error_y;
    // target_thrust.z = g_vehicleMass * (setpoint->acceleration.z + GRAVITY_MAGNITUDE) + kp_z  * r_error.z + kd_z  * v_error.z + ki_z  * i_error_z;
  // } else {
    // target_thrust.x = -sinf(radians(setpoint->attitude.pitch));
    // target_thrust.y = -sinf(radians(setpoint->attitude.roll));
    // In case of a timeout, the commander tries to level, ie. x/y are disabled, but z will use the previous setting
    // In that case we ignore the last feedforward term for acceleration
    // if (setpoint->mode.z == modeAbs) {
      // target_thrust.z = g_vehicleMass * GRAVITY_MAGNITUDE + kp_z  * r_error.z + kd_z  * v_error.z + ki_z  * i_error_z;
    // } else {
      // target_thrust.z = 1;
    // }
  // }

  // Rate-controlled YAW is moving YAW angle setpoint
  // if (setpoint->mode.yaw == modeVelocity) {
  //   desiredYaw = state->attitude.yaw + setpoint->attitudeRate.yaw * dt;
  // } else if (setpoint->mode.yaw == modeAbs) {
  //   desiredYaw = setpoint->attitude.yaw;
  // } else if (setpoint->mode.quat == modeAbs) {
  //   struct quat setpoint_quat = mkquat(setpoint->attitudeQuaternion.x, setpoint->attitudeQuaternion.y, setpoint->attitudeQuaternion.z, setpoint->attitudeQuaternion.w);
  //   struct vec rpy = quat2rpy(setpoint_quat);
  //   desiredYaw = degrees(rpy.z);
  // }

  // Z-Axis [zB]
  // struct quat q = mkquat(state->attitudeQuaternion.x, state->attitudeQuaternion.y, state->attitudeQuaternion.z, state->attitudeQuaternion.w);
  // struct mat33 R = quat2rotmat(q);
  // z_axis = mcolumn(R, 2);

  // yaw correction (only if position control is not used)
  // if (setpoint->mode.x != modeAbs) {
    // struct vec x_yaw = mcolumn(R, 0);
    // x_yaw.z = 0;
    // x_yaw = vnormalize(x_yaw);
    // struct vec y_yaw = vcross(mkvec(0, 0, 1), x_yaw);
    // struct mat33 R_yaw_only = mcolumns(x_yaw, y_yaw, mkvec(0, 0, 1));
    // target_thrust = mvmul(R_yaw_only, target_thrust);
  // }

  // Current thrust [F]
  // current_thrust = vdot(target_thrust, z_axis);
  /////////////////////////////////////////////////////////////////////////////////


  // Calculate axis [zB_des]

  // setting LOGGING param values
  // In degrees
  angVel_x = setpoint->attitudeRate.roll;
  angVel_y = setpoint->attitudeRate.pitch;
  angVel_z = setpoint->attitudeRate.yaw;

  quat_x=state->attitudeQuaternion.x;
  quat_y=state->attitudeQuaternion.y;
  quat_z=state->attitudeQuaternion.z;
  quat_w=state->attitudeQuaternion.w;

  state_x=state->position.x;
  state_y=state->position.y;
  state_z=state->position.z;

  ref_x = setpoint->position.x;
  ref_y = setpoint->position.y;
  ref_z = setpoint->position.z;

  rot_des_z = setpoint->velocity.x;
  rot_des_y = setpoint->velocity.y;
  rot_des_x = setpoint->velocity.z;
  //



  // Thrust calculation from angular acceleration (Z body frame direction) input
  current_thrust = g_vehicleMass * setpoint->acceleration.z;
  cmd_z_acc = setpoint->acceleration.z;
  //

  // Angular velocity Controller
  // float err_d_roll = 0;
  // float err_d_pitch = 0;

  float stateAttitudeRateRoll = radians(sensors->gyro.x);
  float stateAttitudeRatePitch = -radians(sensors->gyro.y);
  float stateAttitudeRateYaw = radians(sensors->gyro.z);

  // ew.x = radians(setpoint->attitudeRate.roll) - stateAttitudeRateRoll;
  // ew.y = -radians(setpoint->attitudeRate.pitch) - stateAttitudeRatePitch;
  // ew.z = radians(setpoint->attitudeRate.yaw) - stateAttitudeRateYaw;

  ew.x = radians(setpoint->attitudeRate.roll) - stateAttitudeRateRoll;
  ew.y = -radians(setpoint->attitudeRate.pitch) - stateAttitudeRatePitch;
  ew.z = radians(setpoint->attitudeRate.yaw) - stateAttitudeRateYaw;

  // integral terms
  i_error_omega_yaw += ew.z*dt;
  i_error_omega_yaw = clamp(i_error_omega_yaw, -i_range_yaw, i_range_yaw);
  i_error_omega_roll += ew.x * dt;
  i_error_omega_roll = clamp(i_error_omega_roll, -i_range_roll, i_range_roll);
  i_error_omega_pitch += ew.y * dt;
  i_error_omega_pitch = clamp(i_error_omega_pitch, -i_range_pitch, i_range_pitch);

  // for logging
  i_roll = i_error_omega_roll;
  i_pitch = i_error_omega_pitch;
  i_yaw = i_error_omega_yaw;

  // derivative terms

  float err_d_roll = 0;
  float err_d_pitch = 0;
  if (prev_omega_roll == prev_omega_roll) { /*d part initialized*/
    err_d_roll = ((radians(setpoint->attitudeRate.roll) - prev_setpoint_omega_roll) - (stateAttitudeRateRoll - prev_omega_roll)) / dt;
    err_d_pitch = (-(radians(setpoint->attitudeRate.pitch) - prev_setpoint_omega_pitch) - (stateAttitudeRatePitch - prev_omega_pitch)) / dt;
  }
  prev_omega_roll = stateAttitudeRateRoll;
  prev_omega_pitch = stateAttitudeRatePitch;
  prev_setpoint_omega_roll = radians(setpoint->attitudeRate.roll);
  prev_setpoint_omega_pitch = radians(setpoint->attitudeRate.pitch);

  M.x = kw_xy * ew.x + ki_w_x*i_error_omega_roll + kd_omega_rp*err_d_roll; 
  M.y = kw_xy * ew.y + ki_w_y*i_error_omega_pitch + kd_omega_rp*err_d_pitch;
  M.z = kw_z  * ew.z + ki_w_z*i_error_omega_yaw;

  // Sending values to the motor
  if (setpoint->mode.z == modeDisable) {
    control->thrust = setpoint->thrust;
  } else {
    control->thrust = massThrust * current_thrust;
  }
  
  // control->thrust = setpoint->acceleration.z;
  cmd_thrust = control->thrust;
  r_roll = radians(sensors->gyro.x);
  r_pitch = -radians(sensors->gyro.y);
  r_yaw = radians(sensors->gyro.z);
  accelz = sensors->acc.z;

  if (control->thrust > 0) {
    control->roll = clamp(M.x, -32000, 32000);
    control->pitch = clamp(M.y, -32000, 32000);
    control->yaw = clamp(-M.z, -32000, 32000);

    cmd_roll = control->roll;
    cmd_pitch = control->pitch;
    cmd_yaw = control->yaw;

  } else {
    control->roll = 0;
    control->pitch = 0;
    control->yaw = 0;

    cmd_roll = control->roll;
    cmd_pitch = control->pitch;
    cmd_yaw = control->yaw;

    controllerRwikReset();
  }
}

PARAM_GROUP_START(ctrlRwik)
PARAM_ADD(PARAM_FLOAT, mass, &g_vehicleMass)
PARAM_ADD(PARAM_FLOAT, massThrust, &massThrust)
PARAM_ADD(PARAM_FLOAT, kw_xy, &kw_xy)
PARAM_ADD(PARAM_FLOAT, kw_z, &kw_z)
PARAM_ADD(PARAM_FLOAT, kd_omega_rp, &kd_omega_rp)
PARAM_ADD(PARAM_FLOAT, ki_w_z, &ki_w_z)
PARAM_ADD(PARAM_FLOAT, ki_w_x, &ki_w_x)
PARAM_ADD(PARAM_FLOAT, ki_w_y, &ki_w_y)

PARAM_GROUP_STOP(ctrlRwik)

LOG_GROUP_START(ctrlRwik)
LOG_ADD(LOG_FLOAT, cmd_thrust, &cmd_thrust)
LOG_ADD(LOG_FLOAT, cmd_roll, &cmd_roll)
LOG_ADD(LOG_FLOAT, cmd_pitch, &cmd_pitch)
LOG_ADD(LOG_FLOAT, cmd_yaw, &cmd_yaw)
LOG_ADD(LOG_FLOAT, r_roll, &r_roll)
LOG_ADD(LOG_FLOAT, r_pitch, &r_pitch)
LOG_ADD(LOG_FLOAT, r_yaw, &r_yaw)
LOG_ADD(LOG_FLOAT, accelz, &accelz)
LOG_ADD(LOG_FLOAT, zdx, &z_axis_desired.x)
LOG_ADD(LOG_FLOAT, zdy, &z_axis_desired.y)
LOG_ADD(LOG_FLOAT, zdz, &z_axis_desired.z)

LOG_ADD(LOG_FLOAT, angVel_x, &angVel_x)
LOG_ADD(LOG_FLOAT, angVel_y, &angVel_y)
LOG_ADD(LOG_FLOAT, angVel_z, &angVel_z)

LOG_ADD(LOG_FLOAT, state_x, &state_x)
LOG_ADD(LOG_FLOAT, state_y, &state_y)
LOG_ADD(LOG_FLOAT, state_z, &state_z)

LOG_ADD(LOG_FLOAT, quat_x, &quat_x)
LOG_ADD(LOG_FLOAT, quat_y, &quat_y)
LOG_ADD(LOG_FLOAT, quat_z, &quat_z)
LOG_ADD(LOG_FLOAT, quat_w, &quat_w)

LOG_ADD(LOG_FLOAT, ref_x, &ref_x)
LOG_ADD(LOG_FLOAT, ref_y, &ref_y)
LOG_ADD(LOG_FLOAT, ref_z, &ref_z)

LOG_ADD(LOG_FLOAT, i_roll, &i_roll)
LOG_ADD(LOG_FLOAT, i_pitch, &i_pitch)
LOG_ADD(LOG_FLOAT, i_yaw, &i_yaw)

// LOG_ADD(LOG_FLOAT, rot_des_z, &rot_des_z)
// LOG_ADD(LOG_FLOAT, rot_des_y, &rot_des_y)
// LOG_ADD(LOG_FLOAT, rot_des_x, &rot_des_x)

LOG_ADD(LOG_FLOAT, cmd_z_acc, &cmd_z_acc)

LOG_GROUP_STOP(ctrlRwik)