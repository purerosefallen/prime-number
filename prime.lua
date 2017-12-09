local prime_list={}
local current=0
function output(n,file)
	print(n)
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

function load_prime()
	for line in io.lines("res.txt") do
		local n=tonumber(line)
		if n then table.insert(prime_list,n) end
	end
	local maxc=prime_list[#prime_list]
	current=math.floor(maxc/10)*10
	print("Loaded prime from file.")
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

local file=io.open("res.txt","a+")
while true do
	check_prime(current+1,file)
	check_prime(current+3,file)
	check_prime(current+7,file)
	check_prime(current+9,file)
	current=current+10
end
file:close()