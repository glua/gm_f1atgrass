AddCSLuaFile()

SWEP.PrintName = "VOXGUN++"

SWEP.UseHands = true
SWEP.WorldModel = "models/weapons/w_357.mdl"
SWEP.ViewModel = "models/weapons/c_357.mdl"

SWEP.Primary.Automatic = true
SWEP.Secondary.Automatic = true

function SWEP:SetupDataTables()
	self:NetworkVar("Int",0,"BrushSize")
end

function SWEP:Initialize()
	self:SetBrushSize(100)
end

function SWEP:PrimaryAttack()
	if IsFirstTimePredicted() then
		if !self.Owner:KeyDown(IN_RELOAD) then self:EmitSound( "ambient/explosions/explode_1.wav" ) end

		if SERVER then
			local b = self:GetBrushSize()
			if self.Owner:KeyDown(IN_RELOAD) then
				if b<5000 then self:SetBrushSize(b+5) end
				return
			end

			local tr = self.Owner:GetEyeTrace()
			if b>0 then
				local off = Vector(b,b,b)
				VOXL:setRegionAt(tr.HitPos+off,tr.HitPos-off,0)
			else
				VOXL:setSphereAt(tr.HitPos,math.abs(b),0)
			end
		end
	end

	self:SetNextPrimaryFire(CurTime()+1)
end

function SWEP:SecondaryAttack()
	if IsFirstTimePredicted() then
		if !self.Owner:KeyDown(IN_RELOAD) then self:EmitSound( "npc/env_headcrabcanister/explosion.wav" ) end

		if SERVER then
			local b = self:GetBrushSize()
			if self.Owner:KeyDown(IN_RELOAD) then
				if b>-5000 then self:SetBrushSize(b-5) end
				return
			end

			local tr = self.Owner:GetEyeTrace()
			if b>0 then
				local off = Vector(b,b,b)
				VOXL:setRegionAt(tr.HitPos+off,tr.HitPos-off,self.Owner:GetInfoNum("voxl_brush_mat",5))
			else
				VOXL:setSphereAt(tr.HitPos,math.abs(b),self.Owner:GetInfoNum("voxl_brush_mat",5))
			end
		end
	end

	self:SetNextSecondaryFire(CurTime()+1)
end

local mat = Material("models/wireframe")

function SWEP:VoxlDraw()
	local b = self:GetBrushSize()
	local tr = self.Owner:GetEyeTrace()
	render.SetMaterial(mat)

	if b>0 then
		local off = Vector(b,b,b)
		render.DrawBox(tr.HitPos,Angle(0,0,0),-off,off)
	else
		render.DrawSphere(tr.HitPos,math.abs(b),10,10)
	end
end