/*
 * @author: Adrian Tarin
 * @date: 28/10/2024
 * @file: Fitness.java
 */

public class Fitness{
    //data members
    private int temperature, humidity, windSpeed, uVIndex, activity, mET;
    private double heatIndex, duration, weight, caloriesBurned;
    private String rain;



    //constructor
    public Fitness(){
    }

    //methods
    //set methods
    public void setWeatherDetails(int temperature, int humidity, int windSpeed, int uVIndex, String rain, double weight){
        this.temperature = temperature;
        this.humidity = humidity;
        this.windSpeed = windSpeed;
        this.uVIndex = uVIndex;
        this.rain = rain;
        this.weight = weight;
    }

    public void setActivityDetails(int activity, double  duration){
        this.activity = activity;
        this.duration = duration;
    }

    public void setWeight(double weight){
        this.weight = weight;
    }


    //computation methods
    public void computeTemperatureConditions(){
        System.out.println("Weather Advice:");
        if (temperature < 0 || rain.equals("yes")){
            System.out.println("Recommended indoor activities like yoga or strength training.");
        } else if (temperature >= 0 && temperature <= 10) {
            System.out.println("Recommended outdoor activities like jogging or hiking, and advise dressing warmly.");
        } else if (temperature > 10 && temperature <= 25){
            System.out.println("Recommended outdoor activities such as running, cycling, or tennis.");
        } else {
            System.out.println("Recommended swimming or water sports, and suggest doing outdoor activities in the early morning or evening to avoid the heat.");
        } 
    }

    public void computeHeatIndex(){
        if (temperature >= 20 && humidity <= 40){
            heatIndex =  Math.round(temperature + (0.33 * humidity) - (0.7 * windSpeed) -4);
            System.out.println("Heat Index: " + heatIndex + "ºC");
            if (heatIndex > 30){
                System.out.println("Avoid strenuous outdoor activities. Consider alternatives like walking or swimming.");
            } else {
            System.out.println("There is no specific guidance based on that temperature.");
            }
        } else {
            System.out.println("There is no specific guidance based on that temperature.");
        }
    }
    //1m/s is equal 3.6km/h
    public void computeCheckWindSpeed(){
        System.out.println("Wind Advice: ");
        if (windSpeed > (40/3.6)){
            System.out.println("Avoid activities like cycling or running.");
        } else if (windSpeed >= (20/3.6) && windSpeed <= (40/3.6)){
            System.out.println("Recommended activities like jogging or hiking in sheltered areas.");
        } else {
            System.out.println("All outdoor activities are safe to perform.");
        }
    }

    public void computeUVIndexPrecautions(){
        System.out.println("UV Protection Advice: ");
        if (uVIndex > 7){
            System.out.println("Apply sunscreen, avoid direct sunlight during peak hours (10 AM - 4 PM), and wear protective clothing, a hat, and sunglasses.");
        } else if (uVIndex >= 5 && uVIndex <=7){
            System.out.println("It is advised to use sunscreen and wear a hat.");
        } else {
            System.out.println("No specific sun protection is required, though using sunscreen is still encouraged.");
        }
    }

    public void computeCaloriesBurned(){
        if (activity == 1){
            mET = 7;
        } else if (activity == 2){
            mET = 8;
        } else if (activity == 3){
            mET = 6;
        } else if (activity == 4){
            mET = 1;
        } else if (activity == 5){
            mET = 9;
        } else if (activity == 6){
            mET = 10;
        } else if (activity == 7){
            mET = 5;
        } else if (activity == 8){
            mET = 4;
        } else if (activity == 9){
            mET = 11;
        } 
    
        caloriesBurned = mET * weight * duration;
        System.out.println("Estimated Calories Burned: " + caloriesBurned + "Kcal");
    } 

}
    
