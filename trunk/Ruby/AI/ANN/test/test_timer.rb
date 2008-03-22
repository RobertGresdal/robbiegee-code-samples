
# The following sequence will execute code as closely as it can to the specified
# frames per second, evaluating twice or more before sleeping if we slept too long
frames = 0.001
start = Time.new
time = start
delay = 0
10.times do
	now = Time.new
	delay += (now-time) #todo: min( (now-time), 1)
	
	if delay < frames then
		puts 'Time: '+(now - time).to_s+'; Delay:'+delay.to_s+' (Sleeping)'
		sleep( frames )
	else 
		puts 'Time: '+(now - time).to_s+'; Delay:'+delay.to_s
	end
	delay -= frames
	
	time = now
end
puts 'Total = '+(Time.new-start).to_s

