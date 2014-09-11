-- pathv6alt 0.2.4 by paramat
-- For latest stable Minetest and back to 0.4.8
-- Depends default
-- License: code WTFPL

-- return to scanning for ground: more dirt paths
-- tune steepness to 0.85

-- Parameters

local WALK = true -- walkable paths
local HSAMP = 0.85 -- Height select amplitude. Maximum steepness of paths
local HSOFF = -0.2 -- Height select noise offset. Bias paths towards base (-) or higher (+) terrain

-- 2D noise for base terrain

local np_base = {
	offset = -4,
	scale = 20,
	spread = {x=250, y=250, z=250},
	seed = 82341,
	octaves = 5,
	persist = 0.6
}

-- 2D noise for higher terrain

local np_higher = {
	offset = 20,
	scale = 16,
	spread = {x=500, y=500, z=500},
	seed = 85039,
	octaves = 5,
	persist = 0.6
}

-- 2D noise for height select

local np_hselect = {
	offset = 0.5,
	scale = 1,
	spread = {x=250, y=250, z=250},
	seed = 4213,
	octaves = 5, -- default = 5
	persist = 0.4 -- default = 0.69
}

-- 2D noise for mud

local np_mud = {
	offset = 4,
	scale = 2,
	spread = {x=200, y=200, z=200},
	seed = 91013,
	octaves = 3,
	persist = 0.55
}

-- 2D noise for patha

local np_patha = {
	offset = 0,
	scale = 1,
	spread = {x=1024, y=1024, z=1024},
	seed = 11711,
	octaves = 3,
	persist = 0.4
}

-- 2D noise for pathb

local np_pathb = {
	offset = 0,
	scale = 1,
	spread = {x=2048, y=2048, z=2048},
	seed = -8017,
	octaves = 4,
	persist = 0.4
}

-- 2D noise for pathc

local np_pathc = {
	offset = 0,
	scale = 1,
	spread = {x=4096, y=4096, z=4096},
	seed = 300707,
	octaves = 5,
	persist = 0.4
}

-- 2D noise for pathd

local np_pathd = {
	offset = 0,
	scale = 1,
	spread = {x=8192, y=8192, z=8192},
	seed = -80033,
	octaves = 6,
	persist = 0.4
}

-- Stuff

dofile(minetest.get_modpath("pathv6alt").."/nodes.lua")

-- On generated function

minetest.register_on_generated(function(minp, maxp, seed)
	if minp.y ~= -32 then
		return
	end

	local t1 = os.clock()
	local x1 = maxp.x
	local y1 = maxp.y
	local z1 = maxp.z
	local x0 = minp.x
	local y0 = minp.y
	local z0 = minp.z
	
	print ("[pathv6alt] chunk minp ("..x0.." "..y0.." "..z0..")")
	
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
	local data = vm:get_data()
	
	local c_air = minetest.get_content_id("air")
	local c_ignore = minetest.get_content_id("ignore")
	local c_tree = minetest.get_content_id("default:tree")
	local c_sand = minetest.get_content_id("default:sand")
	local c_dirt = minetest.get_content_id("default:dirt")
	local c_grass = minetest.get_content_id("default:dirt_with_grass")
	local c_desand = minetest.get_content_id("default:desert_sand")
	local c_stone = minetest.get_content_id("default:stone")
	local c_destone = minetest.get_content_id("default:desert_stone")

	local c_wood = minetest.get_content_id("pathv6alt:wood")
	local c_path = minetest.get_content_id("pathv6alt:path")
	local c_column = minetest.get_content_id("pathv6alt:tree")

	local c_stairn = minetest.get_content_id("pathv6alt:stairn")
	local c_stairs = minetest.get_content_id("pathv6alt:stairs")
	local c_staire = minetest.get_content_id("pathv6alt:staire")
	local c_stairw = minetest.get_content_id("pathv6alt:stairw")
	local c_stairne = minetest.get_content_id("pathv6alt:stairne")
	local c_stairnw = minetest.get_content_id("pathv6alt:stairnw")
	local c_stairse = minetest.get_content_id("pathv6alt:stairse")
	local c_stairsw = minetest.get_content_id("pathv6alt:stairsw")
	
	local c_pstairn = minetest.get_content_id("pathv6alt:pstairn")
	local c_pstairs = minetest.get_content_id("pathv6alt:pstairs")
	local c_pstaire = minetest.get_content_id("pathv6alt:pstaire")
	local c_pstairw = minetest.get_content_id("pathv6alt:pstairw")
	local c_pstairne = minetest.get_content_id("pathv6alt:pstairne")
	local c_pstairnw = minetest.get_content_id("pathv6alt:pstairnw")
	local c_pstairse = minetest.get_content_id("pathv6alt:pstairse")
	local c_pstairsw = minetest.get_content_id("pathv6alt:pstairsw")

	local sidelen = x1 - x0 + 1
	local overlen = sidelen + 1
	local emerlen = sidelen + 32 -- voxelmanip emerged volume edge length for vvii
	local chulens = {x=overlen, y=overlen, z=sidelen} 
	local minpos = {x=x0-1, y=z0-1}

	local nvals_base = minetest.get_perlin_map(np_base, chulens):get2dMap_flat({x=x0+124, y=z0+124}) -- offsets - 1
	local nvals_higher = minetest.get_perlin_map(np_higher, chulens):get2dMap_flat({x=x0+249, y=z0+249})
	local nvals_hselect = minetest.get_perlin_map(np_hselect, chulens):get2dMap_flat({x=x0+124, y=z0+124})
	local nvals_mud = minetest.get_perlin_map(np_mud, chulens):get2dMap_flat({x=x0+99, y=z0+99})

	local nvals_patha = minetest.get_perlin_map(np_patha, chulens):get2dMap_flat(minpos)
	local nvals_pathb = minetest.get_perlin_map(np_pathb, chulens):get2dMap_flat(minpos)
	local nvals_pathc = minetest.get_perlin_map(np_pathc, chulens):get2dMap_flat(minpos)
	local nvals_pathd = minetest.get_perlin_map(np_pathd, chulens):get2dMap_flat(minpos)
	
	local ni = 1
	local stable = {}
	for z = z0 - 1, z1 do
		local n_xprepatha = false
		local n_xprepathb = false
		local n_xprepathc = false
		local n_xprepathd = false
		for x = x0 - 1, x1 do
			local chunk = x >= x0 and z >= z0

			local n_patha = nvals_patha[ni]
			local n_zprepatha = nvals_patha[(ni - overlen)]

			local n_pathb = nvals_pathb[ni]
			local n_zprepathb = nvals_pathb[(ni - overlen)]
			
			local n_pathc = nvals_pathc[ni]
			local n_zprepathc = nvals_pathc[(ni - overlen)]

			local n_pathd = nvals_pathd[ni]
			local n_zprepathd = nvals_pathd[(ni - overlen)]

			if chunk then
				local base = nvals_base[ni]
				local higher = nvals_higher[ni]
				local hselect = nvals_hselect[ni]
				local mudadd = nvals_mud[ni] / 2 + 0.5
				if higher < base then
					higher = base
				end
				local tblend = 0.5 + HSAMP * (hselect + HSOFF)
				tblend = math.min(math.max(tblend, 0), 1)
				local tlevel = base * (1 - tblend) + higher * tblend + mudadd
				local pathy = math.floor(math.max(tlevel, 4))

				if (n_patha >= 0 and n_xprepatha < 0) or (n_patha < 0 and n_xprepatha >= 0) -- patha
				or (n_patha >= 0 and n_zprepatha < 0) or (n_patha < 0 and n_zprepatha >= 0)
				or (n_pathb >= 0 and n_xprepathb < 0) or (n_pathb < 0 and n_xprepathb >= 0) -- pathb
				or (n_pathb >= 0 and n_zprepathb < 0) or (n_pathb < 0 and n_zprepathb >= 0) then
					local wood = true -- scan disk at path level for ground
					for k = -1, 1 do
						local vi = area:index(x-1, pathy, z+k)
						for i = -1, 1 do
							local nodid = data[vi]
							if nodid == c_sand
							or nodid == c_desand
							or nodid == c_dirt
							or nodid == c_grass
							or nodid == c_stone
							or nodid == c_destone then
								wood = false -- use dirt path node
							end
							vi = vi + 1
						end
					end

					local tunnel = false -- scan disk above path for stone
					local excatop
					for k = -1, 1 do
						local vi = area:index(x-1, pathy+5, z+k)
						for i = -1, 1 do
							local nodid = data[vi]
							if nodid == c_stone
							or nodid == c_destone then
								tunnel = true
							end
							vi = vi + 1
						end
					end
					if tunnel then
						excatop = pathy + 4 -- tunnel
					else
						excatop = y1 -- excavate to chunk top
					end

					if WALK then
						if wood then
							local vi = area:index(x-1, pathy, z-1)
							if data[vi] ~= c_wood
							and data[vi] ~= c_path then
								data[vi] = c_stairne
							end
							vi = vi + 1
							if data[vi] ~= c_wood
							and data[vi] ~= c_path then
								data[vi] = c_stairn
							end
							vi = vi + 1
							if data[vi] ~= c_wood
							and data[vi] ~= c_path then
								data[vi] = c_stairnw
							end

							local vi = area:index(x-1, pathy, z)
							if data[vi] ~= c_wood
							and data[vi] ~= c_path then
								data[vi] = c_staire
							end
							vi = vi + 1
							data[vi] = c_wood
							vi = vi + 1
							if data[vi] ~= c_wood
							and data[vi] ~= c_path then
								data[vi] = c_stairw
							end

							local vi = area:index(x-1, pathy, z+1)
							if data[vi] ~= c_wood
							and data[vi] ~= c_path then
								data[vi] = c_stairse
							end
							vi = vi + 1
							if data[vi] ~= c_wood
							and data[vi] ~= c_path then
								data[vi] = c_stairs
							end
							vi = vi + 1
							if data[vi] ~= c_wood
							and data[vi] ~= c_path then
								data[vi] = c_stairsw
							end
						else
							local vi = area:index(x-1, pathy, z-1)
							if data[vi] ~= c_path
							and data[vi] ~= c_wood then
								data[vi] = c_pstairne
							end
							vi = vi + 1
							if data[vi] ~= c_path
							and data[vi] ~= c_wood then
								data[vi] = c_pstairn
							end
							vi = vi + 1
							if data[vi] ~= c_path
							and data[vi] ~= c_wood then
								data[vi] = c_pstairnw
							end

							local vi = area:index(x-1, pathy, z)
							if data[vi] ~= c_path
							and data[vi] ~= c_wood then
								data[vi] = c_pstaire
							end
							vi = vi + 1
							data[vi] = c_path
							vi = vi + 1
							if data[vi] ~= c_path
							and data[vi] ~= c_wood then
								data[vi] = c_pstairw
							end

							local vi = area:index(x-1, pathy, z+1)
							if data[vi] ~= c_path
							and data[vi] ~= c_wood then
								data[vi] = c_pstairse
							end
							vi = vi + 1
							if data[vi] ~= c_path
							and data[vi] ~= c_wood then
								data[vi] = c_pstairs
							end
							vi = vi + 1
							if data[vi] ~= c_path
							and data[vi] ~= c_wood then
								data[vi] = c_pstairsw
							end
						end
						for y = pathy + 1, excatop do
							for k = -1, 1 do
								local vi = area:index(x-1, y, z+k)
								for i = -1, 1 do
									local nodid = data[vi]
									if nodid ~= c_wood
									and nodid ~= c_path
									and nodid ~= c_stairn
									and nodid ~= c_stairs
									and nodid ~= c_staire
									and nodid ~= c_stairw
									and nodid ~= c_stairne
									and nodid ~= c_stairnw
									and nodid ~= c_stairse
									and nodid ~= c_stairsw
									and nodid ~= c_pstairn
									and nodid ~= c_pstairs
									and nodid ~= c_pstaire
									and nodid ~= c_pstairw
									and nodid ~= c_pstairne
									and nodid ~= c_pstairnw
									and nodid ~= c_pstairse
									and nodid ~= c_pstairsw then
										data[vi] = c_air
									end
									vi = vi + 1
								end
							end
						end
					else -- non walkable option
						for y = pathy, excatop do
							for k = -1, 1 do
								local vi = area:index(x-1, y, z+k)
								for i = -1, 1 do
									local nodid = data[vi]
									if y == pathy then
										if wood then
											data[vi] = c_wood
										else
											data[vi] = c_path
										end
									elseif nodid ~= c_wood and nodid ~= c_path then
										data[vi] = c_air
									end
									vi = vi + 1
								end
							end
						end
					end

					if wood and math.random() < 0.25 then
						local vi = area:index(x, pathy - 1, z)
						for y = pathy - 1, y0, -1 do
							local nodid = data[vi]
							if nodid == c_stone
							or nodid == c_destone then
								break
							else
								data[vi] = c_column
							end
							vi = vi - emerlen
						end
					end
				elseif (n_pathc >= 0 and n_xprepathc < 0) or (n_pathc < 0 and n_xprepathc >= 0) -- pathc
				or (n_pathc >= 0 and n_zprepathc < 0) or (n_pathc < 0 and n_zprepathc >= 0)
				or (n_pathd >= 0 and n_xprepathd < 0) or (n_pathd < 0 and n_xprepathd >= 0) -- pathd
				or (n_pathd >= 0 and n_zprepathd < 0) or (n_pathd < 0 and n_zprepathd >= 0) then
					local wood = true -- scan disk at path level for ground
					for k = -2, 2 do
						local vi = area:index(x-2, pathy, z+k)
						for i = -2, 2 do
							local nodid = data[vi]
							if nodid == c_sand
							or nodid == c_desand
							or nodid == c_dirt
							or nodid == c_grass
							or nodid == c_stone
							or nodid == c_destone then
								wood = false
							end
							vi = vi + 1
						end
					end

					local tunnel = false -- scan disk above path for stone
					local excatop
					for k = -2, 2 do
						local vi = area:index(x-2, pathy+5, z+k)
						for i = -2, 2 do
							local nodid = data[vi]
							if nodid == c_stone
							or nodid == c_destone then
								tunnel = true
							end
							vi = vi + 1
						end
					end

					if tunnel then
						excatop = pathy + 4 -- tunnel
					else
						excatop = y1 -- excavate to chunk top
					end

					if WALK then
						if wood then
							local vi = area:index(x-2, pathy, z-2)
							if data[vi] ~= c_path
							and data[vi] ~= c_wood then
								data[vi] = c_stairne
							end
							for iter = 1, 3 do
								vi = vi + 1
								if data[vi] ~= c_path
								and data[vi] ~= c_wood then
									data[vi] = c_stairn
								end
							end
							vi = vi + 1
							if data[vi] ~= c_path
							and data[vi] ~= c_wood then
								data[vi] = c_stairnw
							end

							for k = -1, 1 do
								local vi = area:index(x-2, pathy, z+k)
								if data[vi] ~= c_path
								and data[vi] ~= c_wood then
									data[vi] = c_staire
								end
								for iter = 1, 3 do
									vi = vi + 1
									data[vi] = c_wood
								end
								vi = vi + 1
								if data[vi] ~= c_path
								and data[vi] ~= c_wood then
									data[vi] = c_stairw
								end
							end

							local vi = area:index(x-2, pathy, z+2)
							if data[vi] ~= c_path
							and data[vi] ~= c_wood then
								data[vi] = c_stairse
							end
							for iter = 1, 3 do
								vi = vi + 1
								if data[vi] ~= c_path
								and data[vi] ~= c_wood then
									data[vi] = c_stairs
								end
							end
							vi = vi + 1
							if data[vi] ~= c_path
							and data[vi] ~= c_wood then
								data[vi] = c_stairsw
							end
						else
							local vi = area:index(x-2, pathy, z-2)
							if data[vi] ~= c_path
							and data[vi] ~= c_wood then
								data[vi] = c_pstairne
							end
							for iter = 1, 3 do
								vi = vi + 1
								if data[vi] ~= c_path
								and data[vi] ~= c_wood then
									data[vi] = c_pstairn
								end
							end
							vi = vi + 1
							if data[vi] ~= c_path
							and data[vi] ~= c_wood then
								data[vi] = c_pstairnw
							end

							for k = -1, 1 do
								local vi = area:index(x-2, pathy, z+k)
								if data[vi] ~= c_path
								and data[vi] ~= c_wood then
									data[vi] = c_pstaire
								end
								for iter = 1, 3 do
									vi = vi + 1
									data[vi] = c_path
								end
								vi = vi + 1
								if data[vi] ~= c_path
								and data[vi] ~= c_wood then
									data[vi] = c_pstairw
								end
							end

							local vi = area:index(x-2, pathy, z+2)
							if data[vi] ~= c_path
							and data[vi] ~= c_wood then
								data[vi] = c_pstairse
							end
							for iter = 1, 3 do
								vi = vi + 1
								if data[vi] ~= c_path
								and data[vi] ~= c_wood then
									data[vi] = c_pstairs
								end
							end
							vi = vi + 1
							if data[vi] ~= c_path
							and data[vi] ~= c_wood then
								data[vi] = c_pstairsw
							end
						end

						for y = pathy + 1, excatop do
							for k = -2, 2 do
								local vi = area:index(x-2, y, z+k)
								for i = -2, 2 do
									local nodid = data[vi]
									if nodid ~= c_wood
									and nodid ~= c_path
									and nodid ~= c_stairn
									and nodid ~= c_stairs
									and nodid ~= c_staire
									and nodid ~= c_stairw
									and nodid ~= c_stairne
									and nodid ~= c_stairnw
									and nodid ~= c_stairse
									and nodid ~= c_stairsw
									and nodid ~= c_pstairn
									and nodid ~= c_pstairs
									and nodid ~= c_pstaire
									and nodid ~= c_pstairw
									and nodid ~= c_pstairne
									and nodid ~= c_pstairnw
									and nodid ~= c_pstairse
									and nodid ~= c_pstairsw then
										data[vi] = c_air
									end
									vi = vi + 1
								end
							end
						end
					else -- non walkable option
						for y = pathy, excatop do
							for k = -2, 2 do
								local vi = area:index(x-2, y, z+k)
								for i = -2, 2 do
									if math.abs(k) + math.abs(i) <= 3 then
										local nodid = data[vi]
										if y == pathy then
											if wood then
												data[vi] = c_wood
											else
												data[vi] = c_path
											end
										elseif nodid ~= c_wood and nodid ~= c_path then
											data[vi] = c_air
										end
									end
									vi = vi + 1
								end
							end
						end
					end

					if wood and math.random() < 0.2 then
						for i = -1, 1, 2 do
						for k = -1, 1, 2 do
							local vi = area:index(x+i, pathy-1, z+k)
							for y = pathy - 1, y0, -1 do
								local nodid = data[vi]
								if nodid == c_stone
								or nodid == c_destone then
									break
								else
									data[vi] = c_column
								end
								vi = vi - emerlen
							end
						end
						end
					end
				end
			end

			n_xprepatha = n_patha
			n_xprepathb = n_pathb
			n_xprepathc = n_pathc
			n_xprepathd = n_pathd
			ni = ni + 1
		end
	end
	
	vm:set_data(data)
	vm:set_lighting({day=0, night=0})
	vm:calc_lighting()
	vm:write_to_map(data)

	local chugent = math.ceil((os.clock() - t1) * 1000)
	print ("[pathv6alt] "..chugent.." ms")
end)
