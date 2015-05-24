AddCSLuaFile()

SWEP.PrintName = "VOXGUN"

SWEP.UseHands = true
SWEP.WorldModel = "models/weapons/c_Pistol.mdl"
SWEP.ViewModel = "models/weapons/c_Pistol.mdl"

SWEP.Primary.Automatic = true
SWEP.Secondary.Automatic = true

function SWEP:PrimaryAttack()
	if not IsFirstTimePredicted() then return end

	self:EmitSound( "physics/concrete/concrete_impact_soft1.wav" )

	if SERVER then
		local tr = self.Owner:GetEyeTrace()
		VOXL:setAt(tr.HitPos-tr.HitNormal,0)
	end

	self:SetNextPrimaryFire(CurTime()+.2)
end

function SWEP:SecondaryAttack()
	if not IsFirstTimePredicted() then return end

	self:EmitSound( "physics/concrete/concrete_block_impact_hard1.wav" )
	
	if SERVER then
		local tr = self.Owner:GetEyeTrace()
		VOXL:setAt(tr.HitPos+tr.HitNormal,self.Owner:GetInfoNum("voxl_brush_mat",5))
	end
	self:SetNextSecondaryFire(CurTime()+.2)
end