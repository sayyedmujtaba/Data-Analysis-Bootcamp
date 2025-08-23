weight = int(input("Enter your weight in pounds: "))
height = int(input("Enter your height in inches: "))
BMI = (weight * 703) / (height * height)

if BMI < 18.5:
    print(f"Your BMI is {BMI:.2f}, you are underweight.")
elif BMI < 25:
    print(f"Your BMI is {BMI:.2f}, you have a normal weight.")
elif BMI < 30:
    print(f"Your BMI is {BMI:.2f}, you are overweight.")
elif BMI < 35:
    print(f"Your BMI is {BMI:.2f}, you are obese.")
else:
    print(f"Your BMI is {BMI:.2f}, you are clinically obese.")
