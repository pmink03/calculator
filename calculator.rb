#
# A simple procedural calculator program
# Author: Paul Mink
#

# set the prompt for this application
PROMPT = ">>"

# provide a prompt string and get input from user.
# input_string: the string to display to the user before 
# receiving input
def get_input(message_str)
  # print prompt with text and get initial value
  prompt_string = PROMPT + " " + message_str + " or [q] to quit"
  puts prompt_string
  input_string = gets.chomp
  input_type = nil
  input_val = nil

  # boolean flag to determine if we need to continue
  # in the loop or drop out. false continues
  done = false
  
  # loop until we get either a 'q' or a valid numerical value
  # in the input string. 'q' exits the entire program
  begin
    input_type, input_val = get_input_type(input_string)
    if input_type == 's' && input_val == 'q'
      puts PROMPT + " Bye."
      exit
    elsif input_type == 'i' || input_type == 'f'
      return input_val
    else
      puts "Invalid entry. Please try again or [q] to quit"
      puts prompt_string
      input_string = gets.chomp
    end
  end while done == false
end

# uses regex to determine the string format for an input type
# of either integer, float (real) or plain old string. 
# val: the input value to test
# output: returns a character 'i' for integer, 'f' for float (real)
# or 's' for string. Also returns the value in the format that 
# corresponds to the type (i, f, s)
def get_input_type(val)
  if val =~  /^[-+]?[0-9]*\.[0-9]+$/ # float
    return 'f', val.to_f
  elsif val =~ /^[-+]?[0-9]+$/ #integer
    return 'i', val.to_i
  elsif val.nil?
    return nil, nil
  else
    return 's', val #if not int, float or nil I will just call it a string
  end
end

# provides a prompt to the user to get the math operation to perform
# and prints the values, operation and result.
# 'q' exits the program
# num1, num2: the values to operate on. either int, float or a mix of the two
def do_math(num1, num2)
  prompt_string = PROMPT + " 1)add 2)subtract 3)multiply 4)divide"
  puts prompt_string
  action = gets.chomp
  
  # boolean flag to determine if we need to continue
  # in the loop or drop out. false continues
  done = false
  
  # loop until the user performs a valid action or enters 'q' to quit
  # provides Infinity or -Infinity as appropriate for division by zero
  begin
    case action
        when '1'
          puts PROMPT + "#{num1} added to #{num2} = " + (num1 + num2).to_s
          done = true
        when '2'
          puts PROMPT + "#{num1} minus #{num2} = " + (num1 - num2).to_s
          done = true
        when '3'
          puts PROMPT + "#{num1} times #{num2} = " + (num1 * num2).to_s
          done = true        
        when '4' #watch out for divide by zero
          if( (num2 == 0 || num2 == 0.0) && num1 >= 0 )
            puts PROMPT + "#{num1} divided by #{num2} = Infinity"
          elsif( (num2 == 0 || num2 == 0.0) && num1 < 0 )
            puts PROMPT + "#{num1} divided by #{num2} = -Infinity"
          elsif( (num1%num2) != 0 )
            puts PROMPT + "#{num1} divided by #{num2} = " + (num1/num2.to_f).to_s
          else
            puts PROMPT + "#{num1} divided by #{num2} = " + (num1/num2).to_s
          end
          done = true
        when 'q'
          puts PROMPT + " Bye."
          exit
        else
          puts PROMPT + "Invalid operation selected. Please try again or [q] to quit"
          puts prompt_string
          action = gets.chomp
    end
  end while done == false
end


# get the first number
num1 = get_input("What's the first number?");
# get the second  number
num2 = get_input("What's the second number?");
# do the math
do_math(num1, num2)