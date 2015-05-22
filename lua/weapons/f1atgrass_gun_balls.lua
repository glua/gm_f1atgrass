AddCSLuaFile()

SWEP.PrintName = "BALLGUN"

SWEP.UseHands = true
SWEP.WorldModel = "models/weapons/c_357.mdl"
SWEP.ViewModel = "models/weapons/c_357.mdl"

SWEP.Primary.Automatic = true
SWEP.Secondary.Automatic = true

function SWEP:PrimaryAttack()
	if SERVER then
		self:EmitSound( "ambient/explosions/explode_1.wav" )
		local tr = self.Owner:GetEyeTrace()
		VOXL:setSphereAt(tr.HitPos,self.Owner:GetInfoNum("voxl_brush_size",100),0)
	end

	self:SetNextPrimaryFire(CurTime()+1)
end

function SWEP:SecondaryAttack()
	if SERVER then
		self:EmitSound( "npc/env_headcrabcanister/explosion.wav" )
		local tr = self.Owner:GetEyeTrace()
		VOXL:setSphereAt(tr.HitPos,self.Owner:GetInfoNum("voxl_brush_size",100),self.Owner:GetInfoNum("voxl_brush_mat",5))
	end
	self:SetNextSecondaryFire(CurTime()+1)
end