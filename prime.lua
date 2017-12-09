local prime_list={}
local current=0
local start_number=0
local total=100000
local time_limit=2400
local t=os.clock()
function output(n,file)
	--print(n)
	if file then
		file:write(n.."\n")
	end
end

function check_prime(n,file)
	for _,cn in ipairs(prime_list) do
		if n%cn==0 then return false end
	end
	table.insert(prime_list,n)
	output(n,file)
	return true
end
function check_time()
	if os.clock()-t>1 then
		t=os.clock()
		print("Time remaining: "..math.ceil(2400-t).." sec")
	end
end
function load_prime()
	for line in io.lines("res.txt") do
		local n=tonumber(line)
		if n then table.insert(prime_list,n) end
	end
	local maxc=prime_list[#prime_list]
	current=math.floor(maxc/10)*10
	print("Loaded prime from file. "..#prime_list.." prime numbers have been found previously.")
	start_number=#prime_list
end
function default_prime()
	prime_list={2,3,5,7,11,13,17,19,23,29}
	current=30
	print("Loaded default prime.")
	local file=io.open("res.txt","a+")
	for _,n in ipairs(prime_list) do
		output(n,file)
	end
	file:close()
end

xpcall(load_prime,default_prime)
print("Started finding prime numbers.")

local file=io.open("res.txt","a+")
check_time()
while t<=time_limit do
	check_prime(current+1,file)
	check_time()
	check_prime(current+3,file)
	check_time()
	check_prime(current+7,file)
	check_time()
	check_prime(current+9,file)
	check_time()
	current=current+10
end
file:close()

print("Done. "..(#prime_list-start_number).." prime numbers found in 30 minutes. "..#prime_list.." prime numbers found in total.")