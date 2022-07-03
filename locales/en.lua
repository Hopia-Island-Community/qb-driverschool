local Translations = {
    error = {
		['you_can_only_use_the_vehicle_provided_by_the_driving_school_to_take_this_test'] = 'You can only use the vehicle provided by the driving school to take this test!',
 		['you_need_a_vehicle_to_take_the_test'] = 'You need a vehicle to take the test!',
 		['you_have_been_deducted_5_points'] = 'You have been deducted 5 points',
 		['total_score_has_been_deducted_x'] = 'Total score has been deducted: %{score}',
		['you_dont_have_enough_money'] = 'You don\'t have enough money',
    },
    success = {
		['you_have_completed_your_driving_test'] = 'You have completed your driving test!',
		['very_good_go_to_the_next_point'] = 'Very good, go to the next point!',
    },
	warning = {
		['you_drive_too_fast'] = 'You drive too fast!',
		['you_damaged_the_vehicle'] = 'You damaged the vehicle!',
		['youre_not_wearing_a_seat_belt'] = 'You\'re not wearing a seat belt!',
		['stop_for_pedestrians'] = 'Stop for pedestrians!',
	},
    info = {
        ['get_in_the_vehicle_at_the_starting_line_and_start_the_test'] = 'Get in the vehicle at the starting line and start the test!',
		['fasten_your_seat_belt_and_start_the_engine_to_start_the_test'] = 'Fasten your seat belt and start the engine to start the test!',
		['start_the_engine_to_start_the_test'] = 'Start the engine to start the test!',
		['go_to_the_next_point_the_speed_limit_is_x_kmh'] = 'Go to the next point, the speed limit is: %{speed}km/h',
		['go_to_the_next_point'] = 'Go to the next point!',
		['stop_and_look_to_the_left_it_is_time_to_really_drive_on_the_road_the_speed_limits_in_the_city_are_x_kmh'] = 'Stop and look to the left, it is time to really drive on the road, the speed limits in the city are: %{speed}km/h',
		['very_well_turn_right_and_follow_directions'] = 'Very well, turn right and follow directions!',
		['watch_the_traffic_and_turn_on_your_lights'] = 'Watch the traffic and turn on your lights!',
		['stop_for_passing_vehicles'] = 'Stop for passing vehicles!',
		['it_is_time_to_drive_on_the_highway_speed_limit_x_kmh'] = 'It\'s time to drive on the highway! Speed limit: %{speed}km/h',
		['entered_town_pay_attention_to_your_speed_speed_limit_x_kmh'] = 'Entered town, pay attention to your speed, speed limit: %{speed}km/h',
		['im_impressed_but_dont_forget_to_stay_alert_whilst_driving'] = 'I\'m impressed but don\'t forget to stay alert whilst driving!',
		['you_have_passed_the_driving_theory_test_congratulations'] = 'You have passed the driving theory test congratulations!',
		['you_have_failed_the_driving_theory_test_prepare_well_for_next_time'] = 'You have failed the driving theory test prepare well for next time!',
		['you_have_passed_the_x_class_driving_license_practice_test_congratulations'] = 'You have passed the %{class}-class driver\'s license practice test, congratulations!',
		['you_have_failed_the_practical_test_of_your_x_class_driver_s_license_prepare_well_for_the_next_time'] = 'You have failed the practical test of your %{class}-class driver\'s license prepare, well for the next time!',
		['you_have_already_passed_the_x_class_driver_s_license_if_you_lose_it_go_to_the_city_hall_to_apply_for_a_driver_s_license_again'] = 'You have already passed the %{class}-class driver\'s license, if you lose it, go to the city hall to apply for a driver\'s license again!',
		['someone_is_at_the_starting_line_please_wait_a_moment'] = 'Someone is at the starting line, please wait a moment!',
		['you_have_not_passed_the_theory_test'] = 'You have not passed the theory test!?',
		['have_you_passed_the_theory_test'] = 'Have you passed the theory test?!',
		['driving_school'] = 'Driving School',
		['question'] = 'Question: ',
		['mlcontent'] = '<center><img src=\'dmv.png\' class=\'logo\'><br><p class=\'bold-text\'>Welcome to Driving School</center><br><center>All citizens of Los Santos must pass their exam before they can drive.<br>Take your time, answer with common sense, and do not answer randomly.<br><br> Theory Test<br> - The Theory Test costs $500, this is not refunded if you fail the test.<br> - Don\'t be afraid, the driving school accepts credit, but be careful not to get into debt.<br> - If you fail your test the first time, you can\'t retake it immediately, you\'ll have to take it at a later date.<br><br> Driving Test<br> - The driving test costs depending on the license class, just like the theory test, this payment will not be refunded if you fail.<br> - Make sure you stay alert whilst driving, and avoid accidents!</p></center>',
		['mlbt'] = 'Start',
		['mlprogression'] = 'Progress',
		['mlresultgood'] = '<center><p class=\'bold-text\'>Good work!</p><br><br>You did well during the examination.<br><br>You can close this window, and go take your road test(s).</center>',
		['mlresultbad'] = '<center><p class=\'bold-text\'>You failed</p><br><br>You weren\'t ready for this test, try again later...<br><br></center>',
		['mlsubmit'] = 'Next question',
		['mlclose'] = 'Close',
    },
	menu = {
		['open'] = "Open menu",
	}
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})