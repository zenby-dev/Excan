---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 1/10/12
-- Time: 6:19 PM
--

function PredictPrimes()

	--find primes in 1-1000

	local primes = {}

	local function rec(i)
		for j = 1, i do

			local t = i / j
			if t % 1 == 0 and i ~= j and j ~= 1 then return false end

		end
		return true
	end

	for i = 1, 1000 do

		local res = rec(i)
		if res == true then table.insert(primes, i) end

	end

	--find differences

	local l1d = {}
	local founddifs = {}

	for i = 1, #primes do

		local tp = primes[i]
		local lp = primes[i - 1]
		if tp and lp then

			local df = tp - lp
			if not founddifs[df] then print("New diff at "..(i - 1)..": "..df.." ("..lp.." -> "..tp..")") founddifs[df] = (i - 1) end
			table.insert(l1d, df)

		end

	end

	print(unpack(l1d))
	print("diffs")
	local ps = ""
	for k, v in pairs(founddifs) do
		ps = ps..") | ("..k..", "..v
	end
	print(ps)

end
