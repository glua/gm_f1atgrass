if game.GetMap()!="gm_f1atgrass" then return end

if !VOXL then
	require("voxelate")

	if SERVER then
		VOXL = ents.Create("voxels")
		VOXL.config = {dimensions=Vector(40,40,10), drawExterior = false, atlasMaterial="voxel_test_atlas", scale = 40, atlasWidth=8, atlasHeight=8, useMeshCollisions=true,
			voxelTypes = {
				[1]={atlasIndex=0},
				[2]={atlasIndex=1},
				[3]={atlasIndex=8},
				[4]={atlasIndex=9},
				[5]={atlasIndex=3},
				[6]={atlasIndex=4},
				[7]={atlasIndex=5},
				[8]={atlasIndex=6},
			}
		}
		VOXL:SetPos(Vector(-12800,-12800,0))
		VOXL:Spawn()
	else
		VOXL=true
	end
end

if SERVER then

	hook.Add("PlayerSpawn","vox_playerspawn",function(ply)
		ply:SetPos(Vector(0,0,2200))
		ply:Give("f1atgrass_gun")
		timer.Simple(0,function()
			if !IsValid(ply) then return end
			ply:SetJumpPower(250)
		end)
	end)
end