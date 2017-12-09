local prime_list={}
local current=0

function check_prime(n)
	for _,cn in ipairs(prime_list) do
		if n%cn==0 then return false end
	end
	table.insert(prime_list,n)
	print(n)
	return true
end

function load_prime()
	for line in io.lines("res.txt") do
		local n=tonumber(line)
		if n then table.insert(prime_list,n) end
	end
	current=math.floor(n/10)*10
	print("Loaded prime from file.")
end
function default_prime()
	prime_list={2,3,5,7,11,13,17,19,23,29}
	current=30
	print("Loaded default prime.")
end

xpcall(load_prime,default_prime)

for _,n in ipairs(prime_list) do
	print(n)
end

while true do
	check_prime(current+1)
	check_prime(current+3)
	check_prime(current+7)
	check_prime(current+9)
	current=current+10
end
