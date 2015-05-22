if game.GetMap()!="gm_f1atgrass" then return end

if SERVER then
	AddCSLuaFile()
	resource.AddFile("materials/voxel_test_atlas.vmt")
end

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
				[9]={atlasIndex=11},
				[10]={atlasIndex=12},
				[11]={atlasIndex=13},
				[12]={atlasIndex=14},
				[13]={atlasIndex=19},
				[14]={atlasIndex=20},
				[15]={atlasIndex=21},
				[16]={atlasIndex=22},
				[17]={atlasIndex=24},
				[18]={atlasIndex=25},
				[19]={atlasIndex=26},
				[20]={atlasIndex=27},
				[21]={atlasIndex=28},
				[22]={atlasIndex=29},
				[23]={atlasIndex=30},
				[24]={atlasIndex=31},
				[25]={atlasIndex=32},
				[26]={atlasIndex=33},
				[27]={atlasIndex=34},
				[28]={atlasIndex=35},
				[29]={atlasIndex=36},
				[30]={atlasIndex=37},
				[31]={atlasIndex=38},
				[32]={atlasIndex=39},
				[33]={atlasIndex=40},
				[34]={atlasIndex=41},
				[35]={atlasIndex=42},
				[36]={atlasIndex=43},
				[37]={atlasIndex=44},
				[38]={atlasIndex=45}
			}
		}
		VOXL:SetPos(Vector(-12800,-12800,0))
		VOXL:Spawn()
	else
		VOXL=true
	end
end

if SERVER then

	hook.Add("PlayerSpawn","voxl_playerspawn",function(ply)
		ply:SetPos(Vector(0,0,2200))
		ply:Give("f1atgrass_gun")
		ply:Give("f1atgrass_gun_cubes")
		ply:Give("f1atgrass_gun_balls")
		ply:Give("f1atgrass_gun_cubes_adv")
		ply:Give("f1atgrass_gun_balls_adv")
		timer.Simple(0,function()
			if !IsValid(ply) then return end
			ply:SetJumpPower(250)
		end)
	end)



	//VOXL:setSphere(40,40,40,30,6)
	//VOXL:setRegion(32,32,20,16,16,70,5)
else
	hook.Add("Initialize","voxl_init",function()
		CreateClientConVar("voxl_brush_mat",5, false, true)
		CreateClientConVar("voxl_brush_size",100, false, true)

		local combo = g_ContextMenu:Add("DComboBox")
		combo:SetPos(20,130)
		combo:SetWide(200)

		combo:AddChoice("01 - Grass"			,1)
		combo:AddChoice("05 - Concrete"			,5,true)
		combo:AddChoice("06 - Tiles"			,6)
		combo:AddChoice("07 - Stone"			,7)
		combo:AddChoice("08 - Dirt"				,8)
		combo:AddChoice("09 - Wood"				,9)
		combo:AddChoice("10 - Sand"				,10)
		combo:AddChoice("11 - Metal"			,11)
		combo:AddChoice("12 - Shag Grey"		,12)
		combo:AddChoice("13 - Shag Red"			,13)
		combo:AddChoice("14 - Shag Orange"		,14)
		combo:AddChoice("15 - Shag Yellow"		,15)
		combo:AddChoice("16 - Shag Chartreuse"	,16)
		combo:AddChoice("17 - Shag Green"		,17)
		combo:AddChoice("18 - Shag Lime"		,18)
		combo:AddChoice("19 - Shag Teal"		,19)
		combo:AddChoice("20 - Shag Cyan"		,20)
		combo:AddChoice("21 - Shag Sky Blue"	,21)
		combo:AddChoice("22 - Shag Blue"		,22)
		combo:AddChoice("23 - Shag Indigo"		,23)
		combo:AddChoice("24 - Shag Violet"		,24)
		combo:AddChoice("25 - Shag Purple"		,25)
		combo:AddChoice("26 - Shag Magenta"		,26)
		combo:AddChoice("27 - Shag White"		,27)
		combo:AddChoice("28 - Shag Black"		,28)
		combo:AddChoice("29 - Cobblestone"		,29)
		combo:AddChoice("30 - Mossy Stone"		,30)
		combo:AddChoice("31 - Hex Stone"		,31)
		combo:AddChoice("32 - Mossy Path"		,32)
		combo:AddChoice("33 - Slate"			,33)
		combo:AddChoice("34 - Small Brick"		,34)
		combo:AddChoice("35 - Large Brick"		,35)
		combo:AddChoice("36 - Gravel"			,36)
		combo:AddChoice("37 - CPU"				,37)
		combo:AddChoice("38 - Mechanical Block"	,38)

		combo.OnSelect = function(self,index,value,data)
			RunConsoleCommand("voxl_brush_mat",data)
		end

		local combo2 = g_ContextMenu:Add("DComboBox")
		combo2:SetPos(20,160)
		combo2:SetWide(200)

		combo2:AddChoice(100,nil,true)
		combo2:AddChoice(200)
		combo2:AddChoice(300)
		combo2:AddChoice(400)
		combo2:AddChoice(500)
		combo2:AddChoice(600)
		combo2:AddChoice(700)
		combo2:AddChoice(800)
		combo2:AddChoice(900)
		combo2:AddChoice(1000)

		combo2.OnSelect = function(self,index,value,data)
			RunConsoleCommand("voxl_brush_size",value)
		end
	end)
end