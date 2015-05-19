AddCSLuaFile()

SWEP.PrintName = "VOXGUN"

SWEP.UseHands = true
SWEP.WorldModel = "models/weapons/c_Pistol.mdl"
SWEP.ViewModel = "models/weapons/c_Pistol.mdl"

SWEP.Primary.Automatic = true
SWEP.Secondary.Automatic = true

function SWEP:PrimaryAttack()
	if SERVER then
		self:EmitSound( "physics/concrete/concrete_break2.wav" )

		local tr = self.Owner:GetEyeTrace()
		VOXL:setAt(tr.HitPos-tr.HitNormal,0)
	end

	self:SetNextPrimaryFire(CurTime()+.2)
end

function SWEP:SecondaryAttack()
	if SERVER then
		self:EmitSound( "physics/concrete/concrete_block_impact_hard1.wav" )
		
		local tr = self.Owner:GetEyeTrace()
		VOXL:setAt(tr.HitPos+tr.HitNormal,5)
	end
	self:SetNextSecondaryFire(CurTime()+.2)
end