/*
 * COrientation.cpp
 *
 *  Created on: 2012-8-17
 *      Author: Administrator
 */

#include "COrientation.h"

COrientation::COrientation() {
	// TODO Auto-generated constructor stub

}

COrientation::~COrientation() {
	// TODO Auto-generated destructor stub
}

void COrientation::init() {
	// TODO Auto-generated destructor stub

	 orientation_get(&direction, &orientation_angle);

	if (sensor_is_supported(SENSOR_TYPE_AZIMUTH_PITCH_ROLL)) {

		static const int SENSOR_RATE = 25000;
		sensor_set_rate(SENSOR_TYPE_AZIMUTH_PITCH_ROLL, SENSOR_RATE);
		sensor_set_skip_duplicates(SENSOR_TYPE_AZIMUTH_PITCH_ROLL, true);
		sensor_request_events(SENSOR_TYPE_AZIMUTH_PITCH_ROLL);
	}

	if (sensor_is_supported(SENSOR_TYPE_ACCELEROMETER)) {
		sensor_set_rate(SENSOR_TYPE_ACCELEROMETER, ACCELEROMETER_RATE);
		sensor_set_skip_duplicates(SENSOR_TYPE_ACCELEROMETER, true);
		sensor_request_events(SENSOR_TYPE_ACCELEROMETER);
	}

	force_x = 0;
	force_y = 0;
	force_z = 0;

	azimuth = 0;
	pitch = 0;
	roll = 0;

	sensor_domain = sensor_get_domain();
}

void COrientation::getDate(bps_event_t * event)
{
	  if (bps_event_get_domain(event) == sensor_domain)
	  {
		   if (bps_event_get_code(event) == SENSOR_AZIMUTH_PITCH_ROLL_READING)
		   {
			   sensor_event_get_apr(event, &azimuth, &pitch, &roll);
		   }

		   if (SENSOR_ACCELEROMETER_READING == bps_event_get_code(event))
		   {
				 sensor_event_get_xyz(event,&force_x,&force_y,&force_z);
		   }
	  }
}
