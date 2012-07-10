void Arm(object oTrap) {
	SetPlotFlag(OBJECT_SELF, FALSE);
	SetTrapDisarmable(OBJECT_SELF, TRUE);
	SetImmortal(OBJECT_SELF, FALSE);
	SetTrapActive(OBJECT_SELF, TRUE);
}

void main() {
	// Re-enable in 10 minutes.
	SetPlotFlag(OBJECT_SELF, TRUE);
	SetTrapDisarmable(OBJECT_SELF, FALSE);
	SetImmortal(OBJECT_SELF, TRUE);
	SetTrapActive(OBJECT_SELF, FALSE);
	DelayCommand(600.0, Arm(OBJECT_SELF));
}