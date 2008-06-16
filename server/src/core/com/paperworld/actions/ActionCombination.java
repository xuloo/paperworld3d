package com.paperworld.actions;

/**
 * An action combination is a set of actions that can be performed
 * at the same time.
 */
public class ActionCombination extends ActionCompound {
	/**
     * Checks if this action can interrupt. The combination can
     * interrupt if any of its actions can.
     */
	@Override
	public boolean canInterrupt() {
		Action next = subActions;
		while (next != null) {
			if (next.canInterrupt())
				return true;
			next = next.next;
		}
		return false;
	}

    /**
     * Returns true if all the sub-actions is done. Otherwise the
     * manager keeps scheduling the action.
     */
	@Override
	public boolean isComplete() {
		Action next = subActions;
		while (next != null) {
			if (!next.isComplete())
				return false;
			next = next.next;
		}
		return true;
	}

    /**
     * Called to make the action do its stuff. It calls all its
     * subactions.
     */
	@Override
	public void act() {
		Action next = subActions;
		while (next != null) {
			if (!next.isComplete())
				next.act();
			next = next.next;
		}
	}
}
