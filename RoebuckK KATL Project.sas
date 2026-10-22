* Kealey Roebuck STAT 3130 Project;

proc import
	datafile="/home/u64484851/STAT 3130/Project/flight_data_2024_sample.xlsx"
	out=work.flights replace
	dbms=xlsx;
	sheet="ATL";
	getnames=Y;

* 1. One-Way ANOVA: Average Departure Delays Throughout the Week

  H0: The population mean departure delays at Hartsfield-Jackson
      Atlanta International Airport (KATL) are the same for all 7
      days of the week
  
  HA: At least one day of the week has a population mean depature delay
      that is different from the other days;

proc anova data=flights;
	class day_of_week;
	model dep_delay=day_of_week;
	means day_of_week;
	label day_of_week='Day of Week (1=Mon, 2=Tue, 3=Wed, 4=Thu, 5=Fri, 6=Sat, 7=Sun)';
	* p-value = 0.2339
	  I fail to reject H0, there's not enough eveidence to suggest that
	  the mean departure delay differs throughout the week;
	

* 2. Multiple Linear Regression: Departure Delay and Route Distance as Predictors of Arrival Delay

  Model
  H0: Neither departure delay time nor route distance are predictors
  of arrival delay time (all slope coefficients are 0)
  
  HA: At least one slope coefficient is not equal to 0
  
  Departure Delay: Controlling for distance, depature delays do not linearly predict
  arrival delays
      
  Route Distance: Controlling for departure delays, route distance does not linearly
  predict arrival delays;
  
proc reg data=flights;
	model arr_delay = dep_delay distance;
	* model p-value < 0.0001
	  departure delay p-value < 0.0001
	  distance p-value = 0.6450;
	  
* 3. Kruskal-Wallis Test: Distributions of Departure Delay for KATL Carriers

  H0: The population distributions of departure delays are the same across
      all carriers operating out of KATL
  
  HA: At least one carrier has a departure delay distribution that is
      different from the others;
      
proc npar1way data=flights wilcoxon;
	var dep_delay;
	class op_unique_carrier;
	* p-value = 0.0007;

