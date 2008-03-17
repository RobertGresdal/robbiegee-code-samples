# aliases functions which allows us to inspect the time 
# running them takes without interfering with the original code

def count number
   number.times do
      number += 1
   end
end

def subtract number
   number.times do
      number -= 1
   end
end 


alias countOriginal count
alias subtractOriginal subtract
$gRec = [] # store the time functions are taking in here


def count number
   start = Time.now # store the start time
   countOriginal number # call the original function
   stop = Time.now # store the end time

   # We should have very little overhead timing 
   # above and after the original function
   $gRec.push ['count '+number.to_s, stop-start]
end

# Do the same here
def subtract number
   start = Time.now
   subtractOriginal number
   stop = Time.now

   $gRec.push ['subtract '+number.to_s, stop-start]
end


count(10000)
count(100000)
count(1000000)
subtract(10000)
subtract(100000)
subtract(1000000)
puts $gRec.inspect