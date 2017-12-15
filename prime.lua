local prime_list={}
local current=0
local start_number=0
local time_limit=2400
local t=os.clock()
function output(i,n)
	--print(n)
	local file=io.open("res/"..i..".txt","w+")
	file:write(n)
	file:close()
end

function check_prime(n)
	for _,cn in ipairs(prime_list) do
		if n%cn==0 then return false end
	end
	table.insert(prime_list,n)
	output(#prime_list,n)
	return true
end
function check_time()
	if os.clock()-t>1 then
		t=os.clock()
		print("Time remaining: "..math.max(math.ceil(time_limit-t),0).." sec")
	end
end

function load_prime()
	local n=1
	local f=io.open("./res/"..n..".txt","r+")
	while f do
		local line=f:read("*a")
		table.insert(prime_list,tonumber(line))
		n=n+1
		f:close()
		f=io.open("./res/"..n..".txt","r+")
	end
	if n>10 then
		local maxc=prime_list[#prime_list]
		current=math.floor(maxc/10)*10
		print("Loaded prime from file. "..#prime_list.." prime numbers have been found previously.")
		start_number=#prime_list
	else
		prime_list={2,3,5,7,11,13,17,19,23,29}
		current=30
		print("Loaded default prime.")
		for i,n in ipairs(prime_list) do
			output(i,n)
		end
	end
end
load_prime()
print("Started finding prime numbers.")

check_time()
while t<=time_limit do
	check_prime(current+1)
	check_time()
	check_prime(current+3)
	check_time()
	check_prime(current+7)
	check_time()
	check_prime(current+9)
	check_time()
	current=current+10
end

print("Done. "..(#prime_list-start_number).." prime numbers found in "..time_limit.." seconds. "..#prime_list.." prime numbers found in total.")