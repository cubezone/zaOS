/*
 * COrientation.h
 *
 *  Created on: 2012-8-17
 *      Author: Administrator
 */

#ifndef CORIENTATION_H_
#define CORIENTATION_H_

#include <bps/orientation.h>
#include <bps/bps.h>
#include <bps/sensor.h>

class COrientation {
public:
	int orientation_angle ;
	orientation_direction_t direction;
	static const int ACCELEROMETER_RATE = 25000;
	float force_x, force_y, force_z;
	float azimuth, pitch, roll;
	int sensor_domain;
	void init();
	void getDate(bps_event_t * event);
	COrientation();
	virtual ~COrientation();
};

#endif /* CORIENTATION_H_ */
