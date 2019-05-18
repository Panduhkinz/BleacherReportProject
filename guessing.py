import random

number = random.randint(1, 100)
guessCount = 1
guessCheck = "wrong"
print("Welcome to the Guessing Game. You have an unlimited number of attempts to correctly guess a randomly "
      "generate number. ")
while guessCheck == "wrong":
    try:
        response = int(input("Please input a number between 0 and 100 for guess number {}: ".format(guessCount)))
        val = int(response)
    except ValueError:
        print("This is not a valid integer, please try again. ")
        continue
    if val < number:
        print("This is lower then expected, please try again. ")
        guessCount += 1
    elif val > number:
        print("This is higher then expected, please try again. ")
        guessCount += 1
    else:
        print("That is the correct number. Congratulations, you correctly guessed the number in {} attempts!"
              .format(guessCount))
        guessCheck = "correct"

exit()
