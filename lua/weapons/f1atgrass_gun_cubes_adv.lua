AddCSLuaFile()

SWEP.PrintName = "CUBEGUN++"

SWEP.UseHands = true
SWEP.WorldModel = "models/weapons/c_irifle.mdl"
SWEP.ViewModel = "models/weapons/c_irifle.mdl"

SWEP.Primary.Automatic = true
SWEP.Secondary.Automatic = true

function SWEP:Initialize()
	if SERVER then
		self.next_reload=0
		self.point_selected = false
	end
end

function SWEP:PrimaryAttack()
	if SERVER and self.point_1 and self.point_2 then
		self:EmitSound( "ambient/machines/teleport1.wav" )
		local tr = self.Owner:GetEyeTrace()
		VOXL:setRegionAt(self.point_1,self.point_2,0)
	end

	self:SetNextPrimaryFire(CurTime()+1)
end

function SWEP:SecondaryAttack()
	if SERVER and self.point_1 and self.point_2 then
		self:EmitSound( "ambient/machines/teleport1.wav" )
		local tr = self.Owner:GetEyeTrace()
		VOXL:setRegionAt(self.point_1,self.point_2,self.Owner:GetInfoNum("voxl_brush_mat",5))
	end
	self:SetNextSecondaryFire(CurTime()+1)
end

function SWEP:Reload()
	if SERVER and CurTime()>self.next_reload then
		self:EmitSound( "buttons/button15.wav" )
		local tr = self.Owner:GetEyeTrace()

		if self.point_selected then
			self.point_1 = tr.HitPos-tr.HitNormal
		else
			self.point_2 = tr.HitPos-tr.HitNormal
		end

		self.point_selected= !self.point_selected
		self.next_reload=CurTime()+1
	end
end