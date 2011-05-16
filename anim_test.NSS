//ga_play_animation
// Conversation script wrapper for ActionPlayAnimation() command.
//
//   sTarget - tag of creature to play animation - default is conversation owner.
//   iAnim   - ANIMATION CONSTANT.
//   fSpeed  - speed animation plays at.
// 	 fDurationSeconds - Duration of animation (doesn't apply to fire & forget animations)
//   fDelayUntilStart  - Not to be confused with DURATION, this controls how long after the node starts in seconds to play the animation.


//ChazM 9/22/06

#include "ginc_param_const"
#include "ginc_math"

void main()
{
/*	if (IsFloatNearInt(fSpeed, 0))
		fSpeed = 1.0f;
*/
	object oTarget = GetObjectByTag("CalimshanDancer");
	
	//object oPlayer=GetFirstPC();
	//if(oTarget == OBJECT_INVALID)
	//SendMessageToPC(oPlayer,"DOH!"); 
	//SendMessageToPC(oPlayer,"Fire");
	string sStringAnim="dance02";
	

	PlayCustomAnimation(oTarget,"dance02", 1, 0.43);
		
		/*ActionWait(5.0);
		break;
		
		case 1:
		PlayCustomAnimation(oTarget,"curtsey", 0, 0.43);
		ActionWait(5.0);
		break;
		
		
		case 2:
		PlayCustomAnimation(oTarget,"flirt", 0, 0.43);
		ActionWait(5.0);
		break;
		
		case 3:
		PlayCustomAnimation(oTarget,"shrug", 0, 0.6);
		ActionWait(5.0);
		break;
		
		case 4:
		PlayCustomAnimation(oTarget,"*whirlwind", 0, 0.83);
		ActionWait(5.0);
		break;
		
		
		
		}
		}*/
		//}
}