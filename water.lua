function measure()
	-- setup pin 7 to be output
    gpio.mode(7, gpio.OUTPUT)
	-- write HIGH to pin 7 to power the moisture sensor
    gpio.write(7,1)
	-- initialze sum and measurement count
	count = 5
	sum = 0
	-- collect count number of measurements
	for i =0, count do
		sum = sum+adc.read(0)
	end
	-- shut off the sensor to minimize power
    gpio.write(7,0)
	
	-- calculate average measurement
	avg = sum / count
	-- return average
	return avg
end

function check(moisture)
	dry = false
	if moisture < 900 then
		dry = true
	end

	return dry
end

function water(seconds)
    -- setup pin 8 to be output
    gpio.mode(2, gpio.OUTPUT)
    -- write HIGH to pin 7 to power the moisture sensor
    gpio.write(2,1)
    tmr.delay(seconds * 1000000)
    gpio.write(2,0)
end


gpio.write(3,gpio.LOW)

soil = measure()
print(soil)
dry = check(soil)
print(dry)
if dry then
    water(5)
    new = measure()
    if new < 900 then
        water(3)
    end
end

gpio.write(3,gpio.HIGH)
    
-- sleep for the maximum amount of time
-- which is 71mmin
--node.dsleep(5000000)
node.dsleep(4294967295)

