# A function that generates prime numbers from 1 to 1000

def prime_numbers():
    for num in range(1, 1000):
        if num > 1:
            for i in range(x, num):
                if (num % i) == 0:
                    break
            else:
                print(num)
