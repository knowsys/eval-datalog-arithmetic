(set-logic UFLRA)
(set-info :status unknown)
(declare-sort Fol 0)
(declare-fun VariantName (Real ) Bool)
(declare-fun LaneNotSafe (Real Real Fol ) Bool)
(declare-fun ExcludedAction (Real Fol ) Bool)
(declare-fun SelfSuggestionDisproven (Real Fol ) Bool)
(declare-fun NotAVariantName (Real ) Bool)
(declare-fun ActionName (Fol ) Bool)
(declare-fun CertifiedVariant (Real ) Bool)
(declare-fun UpdatedVariant (Real ) Bool)
(declare-fun ShouldNotUseLane (Real Real Fol ) Bool)
(declare-fun LaneSafe (Real Real Fol ) Bool)
(declare-fun SuggestedAction (Real Fol ) Bool)
(declare-fun CaseShouldNotUseLane1 (Real Real Fol ) Bool)
(declare-fun CaseShouldNotUseLane2 (Real Real Fol ) Bool)
(declare-fun CaseShouldNotUseLane3 (Real Real Fol ) Bool)
(declare-fun SafeActionDoesNotMatchChangeToLane (Real Real Real Real Real Fol ) Bool)
(declare-fun SafeDistanceSpeedFrontDisproven (Real Real Real Real Real Fol ) Bool)
(declare-fun SafeDistanceSpeedBehindDisproven (Real Real Real Real Real Fol ) Bool)
(declare-fun CaseSafeActionDoesNotMatchChangeToLane (Real Real Real Real Real Fol ) Bool)
(declare-fun EgoCar (Real Real Real Real ) Bool)
(declare-fun NotIncByOne (Real Real ) Bool)
(declare-fun NotDecByOne (Real Real ) Bool)
(declare-fun SafeFrontDisproven (Real Real Real Real Real Fol ) Bool)
(declare-fun FrontDeceleratedSpeedLargerThanDistance (Real Real ) Bool)
(declare-fun DistanceFront (Real Real Real Real Fol ) Bool)
(declare-fun SpeedFront (Real Real Real Real Fol ) Bool)
(declare-fun FrontAcceleratedSpeedLargerThanDistance (Real Real ) Bool)
(declare-fun FrontAcceleratedSpeedLargerThanOtherSpeed (Real Real ) Bool)
(declare-fun FrontDeceleratedSpeedLargerThanOtherSpeed (Real Real ) Bool)
(declare-fun SafeBehindDisproven (Real Real Real Real Real Fol ) Bool)
(declare-fun DistanceBehind (Real Real Real Real Fol ) Bool)
(declare-fun SpeedBehind (Real Real Real Real Fol ) Bool)
(declare-fun BehindAcceleratedSpeedLessThanOtherSpeed (Real Real ) Bool)
(declare-fun BehindDeceleratedSpeedLessThanOtherSpeed (Real Real ) Bool)
(declare-fun ResultDeg (Real Fol ) Bool)
(declare-fun Neq (Real Real ) Bool)
(declare-fun amovestraight () Fol)
(declare-fun achangeleft () Fol)
(declare-fun achangeright () Fol)
(declare-fun adeceleratestraight () Fol)
(declare-fun adecelerateleft () Fol)
(declare-fun adecelerateright () Fol)
(declare-fun aacceleratestraight () Fol)
(declare-fun aaccelerateleft () Fol)
(declare-fun aaccelerateright () Fol)
(declare-fun GC0 () Real)
(declare-fun GC1 () Fol)
(assert (and 
(forall ((x0 Real) (x1 Real) (x2 Fol) )(=> (and (VariantName x0) (LaneNotSafe x0 x1 x2) ) (ExcludedAction x0 x2) ))
(forall ((x0 Real) (x1 Fol) )(=> (and (VariantName x0) (SelfSuggestionDisproven x0 x1) ) (ExcludedAction x0 x1) ))
(forall ((x0 Real) (x1 Fol) )(=> (and (NotAVariantName x0) (ActionName x1) ) (ExcludedAction x0 x1) ))
(forall ((x0 Real) (x1 Real) (x2 Real) (x3 Fol) )(=> (and (CertifiedVariant x0) (UpdatedVariant x1) (LaneNotSafe x0 x2 x3) ) (ExcludedAction x1 x3) ))
(forall ((x0 Real) (x1 Real) (x2 Fol) (x3 Real) )(=> (and (ShouldNotUseLane x0 x1 x2) (LaneSafe x0 x3 x2) (SuggestedAction x0 x2) (VariantName x0) ) (SelfSuggestionDisproven x0 x2) ))
(forall ((x0 Real) (x1 Real) (x2 Fol) )(=> (CaseShouldNotUseLane1 x0 x1 x2) (ShouldNotUseLane x0 x1 x2) ))
(forall ((x0 Real) (x1 Real) (x2 Fol) )(=> (CaseShouldNotUseLane2 x0 x1 x2) (ShouldNotUseLane x0 x1 x2) ))
(forall ((x0 Real) (x1 Real) (x2 Fol) )(=> (CaseShouldNotUseLane3 x0 x1 x2) (ShouldNotUseLane x0 x1 x2) ))
(forall ((x0 Real) (x1 Real) (x2 Real) (x3 Real) (x4 Real) (x5 Fol) )(=> (SafeActionDoesNotMatchChangeToLane x0 x1 x2 x3 x4 x5) (CaseShouldNotUseLane1 x0 x1 x5) ))
(forall ((x0 Real) (x1 Real) (x2 Real) (x3 Real) (x4 Real) (x5 Fol) )(=> (SafeDistanceSpeedFrontDisproven x0 x1 x2 x3 x4 x5) (CaseShouldNotUseLane2 x0 x1 x5) ))
(forall ((x0 Real) (x1 Real) (x2 Real) (x3 Real) (x4 Real) (x5 Fol) )(=> (SafeDistanceSpeedBehindDisproven x0 x1 x2 x3 x4 x5) (CaseShouldNotUseLane3 x0 x1 x5) ))
(forall ((x0 Real) (x1 Real) (x2 Real) (x3 Real) (x4 Real) (x5 Fol) )(=> (CaseSafeActionDoesNotMatchChangeToLane x0 x1 x2 x3 x4 x5) (SafeActionDoesNotMatchChangeToLane x0 x1 x2 x3 x4 x5) ))
(forall ((x0 Real) (x1 Real) (x2 Real) (x3 Real) (x4 Real) )(=> (and (Neq x0 x1) (LaneSafe x2 x0 amovestraight) (EgoCar x2 x1 x3 x4) ) (CaseSafeActionDoesNotMatchChangeToLane x2 x0 x1 x3 x4 amovestraight) ))
(forall ((x0 Real) (x1 Real) (x2 Real) (x3 Real) (x4 Real) )(=> (and (Neq x0 x1) (LaneSafe x2 x0 adeceleratestraight) (EgoCar x2 x1 x3 x4) ) (CaseSafeActionDoesNotMatchChangeToLane x2 x0 x1 x3 x4 adeceleratestraight) ))
(forall ((x0 Real) (x1 Real) (x2 Real) (x3 Real) (x4 Real) )(=> (and (Neq x0 x1) (LaneSafe x2 x0 aacceleratestraight) (EgoCar x2 x1 x3 x4) ) (CaseSafeActionDoesNotMatchChangeToLane x2 x0 x1 x3 x4 aacceleratestraight) ))
(forall ((x0 Real) (x1 Real) (x2 Real) (x3 Real) (x4 Real) )(=> (and (NotIncByOne x0 x1) (LaneSafe x2 x0 achangeleft) (EgoCar x2 x1 x3 x4) ) (CaseSafeActionDoesNotMatchChangeToLane x2 x0 x1 x3 x4 achangeleft) ))
(forall ((x0 Real) (x1 Real) (x2 Real) (x3 Real) (x4 Real) )(=> (and (NotIncByOne x0 x1) (LaneSafe x2 x0 adecelerateleft) (EgoCar x2 x1 x3 x4) ) (CaseSafeActionDoesNotMatchChangeToLane x2 x0 x1 x3 x4 adecelerateleft) ))
(forall ((x0 Real) (x1 Real) (x2 Real) (x3 Real) (x4 Real) )(=> (and (NotIncByOne x0 x1) (LaneSafe x2 x0 aaccelerateleft) (EgoCar x2 x1 x3 x4) ) (CaseSafeActionDoesNotMatchChangeToLane x2 x0 x1 x3 x4 aaccelerateleft) ))
(forall ((x0 Real) (x1 Real) (x2 Real) (x3 Real) (x4 Real) )(=> (and (NotDecByOne x0 x1) (LaneSafe x2 x0 achangeright) (EgoCar x2 x1 x3 x4) ) (CaseSafeActionDoesNotMatchChangeToLane x2 x0 x1 x3 x4 achangeright) ))
(forall ((x0 Real) (x1 Real) (x2 Real) (x3 Real) (x4 Real) )(=> (and (NotDecByOne x0 x1) (LaneSafe x2 x0 adecelerateright) (EgoCar x2 x1 x3 x4) ) (CaseSafeActionDoesNotMatchChangeToLane x2 x0 x1 x3 x4 adecelerateright) ))
(forall ((x0 Real) (x1 Real) (x2 Real) (x3 Real) (x4 Real) )(=> (and (NotDecByOne x0 x1) (LaneSafe x2 x0 aaccelerateright) (EgoCar x2 x1 x3 x4) ) (CaseSafeActionDoesNotMatchChangeToLane x2 x0 x1 x3 x4 aaccelerateright) ))
(forall ((x0 Real) (x1 Real) (x2 Real) (x3 Real) (x4 Real) (x5 Fol) )(=> (SafeFrontDisproven x0 x1 x2 x3 x4 x5) (SafeDistanceSpeedFrontDisproven x0 x1 x2 x3 x4 x5) ))
(forall ((x0 Real) (x1 Real) (x2 Real) (x3 Real) (x4 Real) (x5 Real) (x6 Real) (x7 Real) )(=> (and (Neq x0 x1) (FrontDeceleratedSpeedLargerThanDistance x2 x3) (LaneSafe x4 x1 adecelerateleft) (EgoCar x4 x0 x5 x2) (DistanceFront x4 x1 x6 x3 adecelerateleft) (SpeedFront x4 x1 x6 x7 adecelerateleft) ) (SafeFrontDisproven x4 x1 x0 x5 x2 adecelerateleft) ))
(forall ((x0 Real) (x1 Real) (x2 Real) (x3 Real) (x4 Real) (x5 Real) (x6 Real) (x7 Real) )(=> (and (Neq x0 x1) (FrontDeceleratedSpeedLargerThanDistance x2 x3) (LaneSafe x4 x1 adecelerateright) (EgoCar x4 x0 x5 x2) (DistanceFront x4 x1 x6 x3 adecelerateright) (SpeedFront x4 x1 x6 x7 adecelerateright) ) (SafeFrontDisproven x4 x1 x0 x5 x2 adecelerateright) ))
(forall ((x0 Real) (x1 Real) (x2 Real) (x3 Real) (x4 Real) (x5 Real) (x6 Real) (x7 Real) )(=> (and (Neq x0 x1) (FrontAcceleratedSpeedLargerThanDistance x2 x3) (LaneSafe x4 x1 aaccelerateleft) (EgoCar x4 x0 x5 x2) (DistanceFront x4 x1 x6 x3 aaccelerateleft) (SpeedFront x4 x1 x6 x7 aaccelerateleft) ) (SafeFrontDisproven x4 x1 x0 x5 x2 aaccelerateleft) ))
(forall ((x0 Real) (x1 Real) (x2 Real) (x3 Real) (x4 Real) (x5 Real) (x6 Real) (x7 Real) )(=> (and (Neq x0 x1) (FrontAcceleratedSpeedLargerThanDistance x2 x3) (LaneSafe x4 x1 aaccelerateright) (EgoCar x4 x0 x5 x2) (DistanceFront x4 x1 x6 x3 aaccelerateright) (SpeedFront x4 x1 x6 x7 aaccelerateright) ) (SafeFrontDisproven x4 x1 x0 x5 x2 aaccelerateright) ))
(forall ((x0 Real) (x1 Real) (x2 Real) (x3 Real) (x4 Real) (x5 Real) (x6 Real) (x7 Real) )(=> (and (> x0 x1) (Neq x2 x3) (LaneSafe x4 x3 achangeleft) (EgoCar x4 x2 x5 x0) (DistanceFront x4 x3 x6 x1 achangeleft) (SpeedFront x4 x3 x6 x7 achangeleft) ) (SafeFrontDisproven x4 x3 x2 x5 x0 achangeleft) ))
(forall ((x0 Real) (x1 Real) (x2 Real) (x3 Real) (x4 Real) (x5 Real) (x6 Real) (x7 Real) )(=> (and (> x0 x1) (Neq x2 x3) (LaneSafe x4 x3 achangeright) (EgoCar x4 x2 x5 x0) (DistanceFront x4 x3 x6 x1 achangeright) (SpeedFront x4 x3 x6 x7 achangeright) ) (SafeFrontDisproven x4 x3 x2 x5 x0 achangeright) ))
(forall ((x0 Real) (x1 Real) (x2 Real) (x3 Real) (x4 Real) (x5 Real) (x6 Real) (x7 Real) )(=> (and (= x0 x1) (FrontAcceleratedSpeedLargerThanDistance x2 x3) (FrontAcceleratedSpeedLargerThanOtherSpeed x2 x4) (LaneSafe x5 x1 aacceleratestraight) (EgoCar x5 x0 x6 x2) (DistanceFront x5 x1 x7 x3 aacceleratestraight) (SpeedFront x5 x1 x7 x4 aacceleratestraight) ) (SafeFrontDisproven x5 x1 x0 x6 x2 aacceleratestraight) ))
(forall ((x0 Real) (x1 Real) (x2 Real) (x3 Real) (x4 Real) (x5 Real) (x6 Real) (x7 Real) )(=> (and (= x0 x1) (FrontDeceleratedSpeedLargerThanDistance x2 x3) (FrontDeceleratedSpeedLargerThanOtherSpeed x2 x4) (LaneSafe x5 x1 adeceleratestraight) (EgoCar x5 x0 x6 x2) (DistanceFront x5 x1 x7 x3 adeceleratestraight) (SpeedFront x5 x1 x7 x4 adeceleratestraight) ) (SafeFrontDisproven x5 x1 x0 x6 x2 adeceleratestraight) ))
(forall ((x0 Real) (x1 Real) (x2 Real) (x3 Real) (x4 Real) (x5 Real) (x6 Real) (x7 Real) )(=> (and (< x0 x1) (> x1 x2) (= x3 x4) (LaneSafe x5 x4 amovestraight) (EgoCar x5 x3 x6 x1) (DistanceFront x5 x4 x7 x2 amovestraight) (SpeedFront x5 x4 x7 x0 amovestraight) ) (SafeFrontDisproven x5 x4 x3 x6 x1 amovestraight) ))
(forall ((x0 Real) (x1 Real) (x2 Real) (x3 Real) (x4 Real) (x5 Fol) )(=> (SafeBehindDisproven x0 x1 x2 x3 x4 x5) (SafeDistanceSpeedBehindDisproven x0 x1 x2 x3 x4 x5) ))
(forall ((x0 Real) (x1 Real) (x2 Real) (x3 Real) (x4 Real) (x5 Fol) (x6 Real) (x7 Real) (x8 Real) )(=> (and (> x0 x1) (Neq x2 x3) (LaneSafe x4 x3 x5) (EgoCar x4 x2 x6 x7) (DistanceBehind x4 x3 x8 x1 x5) (SpeedBehind x4 x3 x8 x0 x5) ) (SafeBehindDisproven x4 x3 x2 x6 x7 x5) ))
(forall ((x0 Real) (x1 Real) (x2 Real) (x3 Real) (x4 Real) (x5 Real) (x6 Real) (x7 Real) )(=> (and (> x0 x1) (= x2 x3) (BehindAcceleratedSpeedLessThanOtherSpeed x4 x0) (LaneSafe x5 x3 aacceleratestraight) (EgoCar x5 x2 x6 x4) (DistanceBehind x5 x3 x7 x1 aacceleratestraight) (SpeedBehind x5 x3 x7 x0 aacceleratestraight) ) (SafeBehindDisproven x5 x3 x2 x6 x4 aacceleratestraight) ))
(forall ((x0 Real) (x1 Real) (x2 Real) (x3 Real) (x4 Real) (x5 Real) (x6 Real) (x7 Real) )(=> (and (> x0 x1) (= x2 x3) (BehindDeceleratedSpeedLessThanOtherSpeed x4 x0) (LaneSafe x5 x3 adeceleratestraight) (EgoCar x5 x2 x6 x4) (DistanceBehind x5 x3 x7 x1 adeceleratestraight) (SpeedBehind x5 x3 x7 x0 adeceleratestraight) ) (SafeBehindDisproven x5 x3 x2 x6 x4 adeceleratestraight) ))
(forall ((x0 Real) (x1 Real) (x2 Real) (x3 Real) (x4 Real) (x5 Real) (x6 Real) (x7 Real) )(=> (and (> x0 x1) (> x0 x2) (= x3 x4) (LaneSafe x5 x4 amovestraight) (EgoCar x5 x3 x6 x1) (DistanceBehind x5 x4 x7 x2 amovestraight) (SpeedBehind x5 x4 x7 x0 amovestraight) ) (SafeBehindDisproven x5 x4 x3 x6 x1 amovestraight) ))
(DistanceBehind 0 2 (- 11) 5 aaccelerateleft) 
(SpeedBehind 0 2 (- 11) 2 aaccelerateleft) 
(DistanceFront 0 2 12 5 aaccelerateleft) 
(SpeedFront 0 2 12 2 aaccelerateleft) 
(LaneSafe 0 2 aaccelerateleft) 
(DistanceFront 0 0 5 0 achangeright) 
(SpeedFront 0 0 5 0 achangeright) 
(LaneNotSafe 0 0 achangeright) 
(DistanceBehind 0 1 (- 11) 5 amovestraight) 
(SpeedBehind 0 1 (- 11) 1 amovestraight) 
(DistanceFront 0 1 7 1 amovestraight) 
(SpeedFront 0 1 7 1 amovestraight) 
(LaneNotSafe 0 1 amovestraight) 
(DistanceBehind 0 2 (- 11) 5 achangeleft) 
(SpeedBehind 0 2 (- 11) 2 achangeleft) 
(DistanceFront 0 2 12 5 achangeleft) 
(SpeedFront 0 2 12 2 achangeleft) 
(LaneSafe 0 2 achangeleft) 
(DistanceBehind 0 1 (- 11) 5 adeceleratestraight) 
(SpeedBehind 0 1 (- 11) 1 adeceleratestraight) 
(DistanceFront 0 1 7 1 adeceleratestraight) 
(SpeedFront 0 1 7 1 adeceleratestraight) 
(LaneNotSafe 0 1 adeceleratestraight) 
(DistanceBehind 0 1 (- 11) 5 aacceleratestraight) 
(SpeedBehind 0 1 (- 11) 1 aacceleratestraight) 
(DistanceFront 0 1 7 1 aacceleratestraight) 
(SpeedFront 0 1 7 1 aacceleratestraight) 
(LaneNotSafe 0 1 aacceleratestraight) 
(DistanceFront 0 0 5 0 aaccelerateright) 
(SpeedFront 0 0 5 0 aaccelerateright) 
(LaneNotSafe 0 0 aaccelerateright) 
(DistanceFront 0 0 5 0 adecelerateright) 
(SpeedFront 0 0 5 0 adecelerateright) 
(LaneNotSafe 0 0 adecelerateright) 
(DistanceBehind 0 2 (- 11) 5 adecelerateleft) 
(SpeedBehind 0 2 (- 11) 2 adecelerateleft) 
(DistanceFront 0 2 12 5 adecelerateleft) 
(SpeedFront 0 2 12 2 adecelerateleft) 
(LaneSafe 0 2 adecelerateleft) 
(EgoCar 0 1 5 3) 
(SuggestedAction 0 aaccelerateleft) 
(SuggestedAction 0 achangeleft) 
(SuggestedAction 0 adecelerateleft) 
(DistanceBehind 1 2 (- 11) 5 achangeleft) 
(SpeedBehind 1 2 (- 11) 2 achangeleft) 
(DistanceFront 1 2 12 5 achangeleft) 
(SpeedFront 1 2 12 2 achangeleft) 
(LaneSafe 1 2 achangeleft) 
(DistanceBehind 1 1 (- 11) 5 amovestraight) 
(SpeedBehind 1 1 (- 11) 1 amovestraight) 
(DistanceFront 1 1 7 1 amovestraight) 
(SpeedFront 1 1 7 1 amovestraight) 
(LaneNotSafe 1 1 amovestraight) 
(DistanceFront 1 0 5 0 achangeright) 
(SpeedFront 1 0 5 0 achangeright) 
(LaneNotSafe 1 0 achangeright) 
(DistanceBehind 1 1 (- 11) 5 adeceleratestraight) 
(SpeedBehind 1 1 (- 11) 1 adeceleratestraight) 
(DistanceFront 1 1 7 1 adeceleratestraight) 
(SpeedFront 1 1 7 1 adeceleratestraight) 
(LaneNotSafe 1 1 adeceleratestraight) 
(DistanceBehind 1 1 (- 11) 5 aacceleratestraight) 
(SpeedBehind 1 1 (- 11) 1 aacceleratestraight) 
(DistanceFront 1 1 7 1 aacceleratestraight) 
(SpeedFront 1 1 7 1 aacceleratestraight) 
(LaneNotSafe 1 1 aacceleratestraight) 
(DistanceBehind 1 2 (- 11) 5 aaccelerateleft) 
(SpeedBehind 1 2 (- 11) 2 aaccelerateleft) 
(DistanceFront 1 2 12 5 aaccelerateleft) 
(SpeedFront 1 2 12 2 aaccelerateleft) 
(LaneSafe 1 2 aaccelerateleft) 
(DistanceFront 1 0 5 0 aaccelerateright) 
(SpeedFront 1 0 5 0 aaccelerateright) 
(LaneNotSafe 1 0 aaccelerateright) 
(DistanceFront 1 0 5 0 adecelerateright) 
(SpeedFront 1 0 5 0 adecelerateright) 
(LaneNotSafe 1 0 adecelerateright) 
(DistanceBehind 1 2 (- 11) 5 adecelerateleft) 
(SpeedBehind 1 2 (- 11) 2 adecelerateleft) 
(DistanceFront 1 2 12 5 adecelerateleft) 
(SpeedFront 1 2 12 2 adecelerateleft) 
(LaneSafe 1 2 adecelerateleft) 
(EgoCar 1 1 5 3) 
(SuggestedAction 1 achangeleft) 
(SuggestedAction 1 aaccelerateleft) 
(SuggestedAction 1 adecelerateleft) 
(VariantName 0) 
(VariantName 1) 
(CertifiedVariant 0) 
(UpdatedVariant 1) 
(ActionName achangeright) 
(ActionName amovestraight) 
(ActionName achangeleft) 
(ActionName adeceleratestraight) 
(ActionName aacceleratestraight) 
(ActionName adecelerateright) 
(ActionName aaccelerateright) 
(ActionName adecelerateleft) 
(ActionName aaccelerateleft) 
(forall ((x0 Real) )(=> (and (Neq x0 0) (Neq x0 1) ) (NotAVariantName x0) ))
(forall ((x0 Real) (x1 Fol) )(=> (ExcludedAction x0 x1) (ResultDeg x0 x1) ))
(forall ((x0 Real) (x1 Real) (x2 Real) )(=> (and (= x0 (- x1 1)) (Neq x2 x0) ) (NotDecByOne x2 x1) ))
(forall ((x0 Real) (x1 Real) (x2 Real) )(=> (and (= x0 (+ x1 1)) (Neq x2 x0) ) (NotIncByOne x2 x1) ))
(forall ((x0 Real) (x1 Real) )(=> (< (+ x0 1) x1) (BehindAcceleratedSpeedLessThanOtherSpeed x0 x1) ))
(forall ((x0 Real) (x1 Real) )(=> (< (- x0 1) x1) (BehindDeceleratedSpeedLessThanOtherSpeed x0 x1) ))
(forall ((x0 Real) (x1 Real) )(=> (> (+ x0 1) x1) (FrontAcceleratedSpeedLargerThanDistance x0 x1) ))
(forall ((x0 Real) (x1 Real) )(=> (> (- x0 1) x1) (FrontDeceleratedSpeedLargerThanDistance x0 x1) ))
(forall ((x0 Real) (x1 Real) )(=> (> (+ x0 1) x1) (FrontAcceleratedSpeedLargerThanOtherSpeed x0 x1) ))
(forall ((x0 Real) (x1 Real) )(=> (> (- x0 1) x1) (FrontDeceleratedSpeedLargerThanOtherSpeed x0 x1) ))
(forall ((x0 Real) (x1 Real) )(=> (< x0 x1) (Neq x0 x1) ))
(forall ((x0 Real) (x1 Real) )(=> (> x0 x1) (Neq x0 x1) ))
(=> (> 0 GC0) false)
(=> (> GC0 1) false)
(=> (ResultDeg GC0 GC1) false)
))
(assert (forall ((x Fol)) (or (= x amovestraight) (= x achangeleft) (= x achangeright) (= x adeceleratestraight) (= x adecelerateleft) (= x adecelerateright) (= x aacceleratestraight) (= x aaccelerateleft) (= x aaccelerateright) )))
(check-sat)
(exit)