export interface LowLevelHardware {
	setPrecharge( value: boolean ): void
	setContactor( value: boolean ): void
}
