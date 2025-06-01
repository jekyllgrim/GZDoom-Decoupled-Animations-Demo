version "4.14.0"

class CubeThing : Actor
{
	Default
	{
		+DECOUPLEDANIMATIONS
		Monster;
		Health 600;
		+NODAMAGETHRUST
		PainChance 64;
		Mass 500;
		Speed 3.2;
		VSpeed 1;
		Radius 32;
		Height 56;
		MeleeRange 128;
		MaxTargetRange 400;
	}

	override void PostBeginPlay()
	{
		Super.PostBeginPlay();
		SetAnimation('spin', framerate: 10, flags:SAF_LOOP|SAF_INSTANT|SAF_NOOVERRIDE);
	}

	States {
	Spawn:
		M000 A 0 A_Look;
		M000 A 10 SetAnimation('spin', framerate: 10, flags:SAF_LOOP|SAF_NOOVERRIDE);
		loop;
	See:
		M000 A 0 A_Chase;
		M000 A 1 SetAnimation('move', flags:SAF_LOOP|SAF_NOOVERRIDE);
		loop;
	Melee:
		M000 A 15
		{
			A_FaceTarget();
			SetAnimation('expand_flip');
		}
		M000 A 33 A_Explode(flags:XF_NOTMISSILE);
		goto See;
	Missile:
		M000 A 8
		{
			A_FaceTarget();
			SetAnimation('expand_forward');
		}
		M000 A 23 A_SpawnProjectile('BaronBall');
		goto See;
	Pain:
		M000 A 15 SetAnimation('spin');
		goto See;
	Death:
		M000 A 10 SetAnimation('death');
		M000 A -1 A_NoBlocking;
		stop;
	}
}