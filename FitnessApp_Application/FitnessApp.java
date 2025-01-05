/*
 * @author: Adrian Tarin
 * @date: 28/10/2024
 * @file: FitnessApp.java
 */

import java.util.Scanner;

public class FitnessApp{
    public static void main(String args[]){
        //declare variables
        int temperature;
        int humidity;
        int windSpeed;
        int uVIndex;
        String rain;
        int activity;
        double weight;
        double duration;
        int userSelection;
        String checkAnotherSet;

        //declare/create objects
        Scanner keyboard = new Scanner(System.in);
        Fitness myFitness = null;
        Fitness myFitnessJustWeight = null;

        //prompt user for input
        String applicationMenu = """
                                
                                 Application Menu

                                 1.	Provide weather details (Temperature, Humidity, Wind Speed, UV Index and rain)
                                 2.	Weather Advice (Temperature and rain conditions) 
                                 3.	Calculate Heat Index
                                 4.	Check Wind Speed conditions
                                 5.	UV Index precautions
                                 6.	Calculate the number of calories burned for an activity
                                 7.	Reset Application
                                 8.	Exit Application

                                 Enter your choice

                                 """;
        String activitiesMenu = """
                                Choose your activity:

                                1. Jogging    2. Cycling     3. Swimming    
                                4. Yoga       5. Strength    6. Hiking
                                7. Running    8. Tennis      9. Water Sports

                                """;


        while (true){
            try {
                //Show Application Menu with options to the user
                System.out.println(applicationMenu);
                userSelection = keyboard.nextInt();
                //User selection: 1. Provide Weather Details
                if (userSelection == 1){
                    //Temperature validation
                    while (true) {
                        try {
                            System.out.println("Temperature in ºC>>");
                            temperature = keyboard.nextInt();
                            if (temperature < -20 || temperature > 50){
                                System.out.println("Please enter a valid input. It should be a number between -20 and 50.");
                                keyboard.next();
                            } else {
                                break;
                            }
                        } catch (Exception e) {
                            System.out.println("Please enter a valid input. It should be a number between -20 and 50.");
                            keyboard.next();
                            }
                    }
                    //Humidity validation
                    while (true) {
                        try {
                            System.out.println("Humidity Percentage>>");
                            humidity = keyboard.nextInt();
                            if (humidity < 0 || humidity > 100){
                                System.out.println("Please enter a valid input. It should be a number between 0 and 100.");
                                keyboard.next();
                            } else {
                                break;
                            }
                        } catch (Exception e) {
                            System.out.println("Please enter a valid input. It should be a number between 0 and 100.");
                            keyboard.next();
                            }
                    }
                    //Wind Speed validation
                    while (true) {
                        try {
                            System.out.println("Wind Speed in m/s>>");
                            windSpeed = keyboard.nextInt();
                            if (windSpeed < 0 || windSpeed > 50){
                                System.out.println("Please enter a valid input. It should be a number between 0 and 50.");
                                keyboard.next();
                            } else {
                                break;
                            }
                        } catch (Exception e) {
                            System.out.println("Please enter a valid input. It should be a number between 0 and 50.");
                            keyboard.next();
                            }
                    }
                    //UV validation
                    while (true) {
                        try {
                            System.out.println("UV Index>>");
                            uVIndex = keyboard.nextInt();
                            if (uVIndex < 0 || uVIndex > 11){
                                System.out.println("Please enter a valid input. It should be a number between 0 and 11.");
                                keyboard.next();
                            } else {
                                break;
                            }
                        } catch (Exception e) {
                            System.out.println("Please enter a valid input. It should be a number between 0 and 11.");
                            keyboard.next();
                            }
                    }
                    //Rain validation
                    while (true) {
                        try {
                            System.out.println("Is it raining heavily or stormy weather (yes/no)?");
                            rain = keyboard.next();
                            if (rain.equals("yes") == false && rain.equals("no") == false){
                                System.out.println("Please enter a valid input. You should type 'yes' or 'no'.");
                                keyboard.next();
                            } else {
                                break;
                            }
                        } catch (Exception e) {
                            System.out.println("Please enter a valid input. You should type 'yes' or 'no'.");
                            keyboard.next();
                            }
                    }
                    //Weight validation
                    while (true) {
                        try {
                            System.out.println("Your Weight in Kg>>");
                            weight = keyboard.nextDouble();
                            if (weight < 30 || weight > 200){
                                System.out.println("Please enter a valid input. It should be a number between 30 and 200.");
                                keyboard.next();
                            } else {
                                break;
                            }
                        } catch (Exception e) {
                            System.out.println("Please enter a valid input. It should be a number between 30 and 200.");
                            keyboard.next();
                            }
                    }                
                    //Create Fitness object and set details
                    myFitness = new Fitness();
                    myFitness.setWeatherDetails(temperature, humidity, windSpeed, uVIndex, rain, weight);
                    System.out.println("Data has been succesfully saved.");    
                
                //User selection: 2. Weather Advice (temperature and rain conditions)
                } else if (userSelection == 2){
                    if (myFitness != null){
                        myFitness.computeTemperatureConditions();
                    } else {
                        System.out.println("Please enter weather details.");
                    }
                //User selection: 3. Calculate Heat Index
                } else if (userSelection == 3){
                    if (myFitness != null){
                        myFitness.computeHeatIndex();
                    } else {
                        System.out.println("Please enter weather details.");
                    }
                //User Selection: 4. Check Wind Speed conditions
                }else if (userSelection == 4){
                    if (myFitness != null){
                        myFitness.computeCheckWindSpeed();
                    } else {
                        System.out.println("Please enter weather details.");
                    }
                //User selection: 5. UV Index precautions
                } else if (userSelection == 5){
                    if (myFitness != null){
                        myFitness.computeUVIndexPrecautions();
                    } else {
                        System.out.println("Please enter weather details.");
                    }
                //User selection: 6. Calculate Calories Burned
                } else if (userSelection == 6){
                    System.out.println(activitiesMenu);
                    activity = keyboard.nextInt();
                    System.out.println("Duration of exercise in hours>>");
                    duration = keyboard.nextDouble();
                    if (myFitness == null){
                        if (myFitnessJustWeight == null){
                            myFitnessJustWeight = new Fitness();
                            System.out.println("Your weight in Kg>>");
                            weight = keyboard.nextDouble();
                            myFitnessJustWeight.setWeight(weight);
                            myFitnessJustWeight.setActivityDetails(activity, duration);
                            myFitnessJustWeight.computeCaloriesBurned();
                        } else {
                            myFitnessJustWeight.setActivityDetails(activity, duration);
                            myFitnessJustWeight.computeCaloriesBurned();
                        }

                    } else {
                        myFitness.setActivityDetails(activity, duration);
                        myFitness.computeCaloriesBurned();
                    }
                //User selection: 7. Reset Application
                } else if (userSelection == 7){
                    myFitness = null;
                    myFitnessJustWeight = null;
                    System.out.println("Application reset successfully. All data has been cleared.");
                //User selection: 8. Exit Application
                } else if (userSelection == 8){
                    System.out.println("Would you like to check another set of conditions?");
                    checkAnotherSet = keyboard.next();
                    if (checkAnotherSet.equals("yes")){
                        myFitness = null;
                        myFitnessJustWeight = null;
                        System.out.println("Application reset successfully. All data has been cleared.");
                    } else {
                        break;
                    }
				//User selection is valid data type but not an option between 1-8
                } else {
                    System.out.println("Selection not valid. Please enter a valid choice.");
                }

            //User input is not an int
            } catch (Exception e) {
                System.out.println("Selection not valid. Please enter a valid choice.");
                keyboard.next();
                }   

        }//end first while (true)
        System.out.println("Thank You for using FitnessApp.\nGood Bye.");
    }//end public static void main(String args[])
}//end puclic class FitnessApp


    



