local TableUtil = {}


function TableUtil.shuffle(Table: {})
	if typeof(Table) == "table" then
		Random.new():Shuffle(Table)
		return Table
	end
end

function TableUtil:Random(Table: {}, allowCycle: false)
	
	Table = table.clone(Table)
	
	if allowCycle then
		self.shuffle(Table)
	end
	
	local NewRandom = {}
	
	function NewRandom.Random()
		local Index = math.random(1, #Table)
		return Table[Index], Index
	end
	
	function NewRandom:Get()
		
		if allowCycle then
			
			if not NewRandom.CycleCache then
				NewRandom.CycleCache = {}
			end
			
			if not Table[1] then
				print(Table)
				Table = NewRandom.CycleCache
				table.clear(NewRandom.CycleCache)
			end
			
			local RandomValue, RandomIndex = NewRandom.Random()

			table.insert(NewRandom.CycleCache, RandomValue)
			table.remove(Table, RandomIndex)

			return RandomValue
			
		else
			return NewRandom.Random()
		end
	
		
	end
	
	return NewRandom
	
end

return TableUtil
