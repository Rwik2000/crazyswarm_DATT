/**
 *    ||          ____  _ __
 * +------+      / __ )(_) /_______________ _____  ___
 * | 0xBC |     / __  / / __/ ___/ ___/ __ `/_  / / _ \
 * +------+    / /_/ / / /_/ /__/ /  / /_/ / / /_/  __/
 *  ||  ||    /_____/_/\__/\___/_/   \__,_/ /___/\___/
 *
 * Crazyflie control firmware
 *
 * Copyright (C) 2011-2012 Bitcraze AB
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, in version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 *
 * Motors.h - Motor driver header file
 *
 * The motors PWM ratio is a value on 16 bits (from 0 to 0xFFFF)
 * the functions of the driver will make the conversions to the actual PWM
 * precision (ie. if the precision is 8bits 0xFFFF and 0xFF00 are equivalents).
 *
 * The precision is set in number of bits by the define MOTORS_PWM_BITS
 * The timer prescaler is set by MOTORS_PWM_PRESCALE
 */
#ifndef __PIEZO_H__
#define __PIEZO_H__

#include <stdint.h>
#include <stdbool.h>
#include "config.h"

/******** Defines ********/

/*** Public interface ***/

/**
 * Piezo Initialization. Configures two output compare channels in PWM mode
 * with one of them inverted to increase power output.
 */
void piezoInit();

/**
 * Test of the motor modules. The test will spin each motor very short in
 * the sequence M1 to M4.
 */
bool piezoTest(void);

/**
 * Set piezo ratio/power.
 */
void piezoSetRatio(uint8_t ratio);

/**
 * Set piezo frequency in hertz.
 */
void piezoSetFreq(uint16_t freq);

#endif /* __MOTORS_H__ */
