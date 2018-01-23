function sendData()

raw=adc.read(0)
--volts = raw*0.00488

-- calculate resistance of the thermistor, assume 10K pull down resistor!
dofile("lut.lua")
local lasttemp = nil
lasttemp = thermistor(raw)

t1 = lasttemp / 10
t2 = lasttemp % 10

--t1 = raw
--t2 = raw

print("Temp:"..t1.."."..string.format("%01d", t2).." C\n")
-- conection to thingspeak.com
print("Sending data to thingspeak.com")
conn=net.createConnection(net.TCP, 0) 
conn:on("receive", function(conn, payload) print(payload) end)
-- api.thingspeak.com 184.106.153.149
conn:connect(80,'184.106.153.149') 
conn:send("GET /update?key=MxxxxxxASCDQ8&field1="..t1.."."..string.format("%01d", t2).." HTTP/1.1\r\n") 


conn:send("Host: api.thingspeak.com\r\n") 
conn:send("Accept: */*\r\n") 
conn:send("User-Agent: Mozilla/4.0 (compatible; esp8266 Lua; Windows NT 5.1)\r\n")
conn:send("\r\n")
conn:on("sent",function(conn)
                      print("Closing connection")
                      conn:close()
                  end)
conn:on("disconnection", function(conn)
                                print("Got disconnection...")
  end)
end

-- send data every X ms to thing speak
tmr.alarm(0, 600000, 1, function() sendData() end )
