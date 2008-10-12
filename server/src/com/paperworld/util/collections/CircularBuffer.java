package com.paperworld.util.collections;

import java.lang.reflect.Array;

public class CircularBuffer<T> {

	public static int DEFAULT_LENGTH = 1000;

	private T[] backingArray;

	private Class<T> elementType;

	public int head = 0;

	public int tail = 0;

	public int index = 0;

	public CircularBuffer(Class<T> elementType) {
		this.elementType = elementType;
		resize();
	}

	public CircularBuffer(Class<T> elementType, int size) {
		this.elementType = elementType;
		resize(size);
	}

	public void resize() {
		resize(DEFAULT_LENGTH);
	}

	@SuppressWarnings("unchecked")
	public void resize(int size) {
		head = 0;
		tail = 0;
		backingArray = (T[]) Array.newInstance(elementType, size);
	}

	public int size() {
		int count = head - tail;

		if (count < 0)
			count += backingArray.length;

		return count;
	}

	public void add(T element) {
		backingArray[head] = element;

		head++;
		if (head >= backingArray.length)
			head -= backingArray.length;
	}

	public void remove() {
		if (!empty()) {
			tail++;
			if (tail >= backingArray.length)
				tail -= backingArray.length;
		}
	}

	public T oldest() {
		return backingArray[tail];
	}

	public T newest() {
		int index = head - 1;

		if (index == -1)
			index = backingArray.length - 1;

		return backingArray[index];
	}

	public boolean empty() {
		return head == tail;
	}

	public void next(int index) {
		index++;

		if (index >= backingArray.length)
			index -= backingArray.length;
	}

	public void previous(int index) {
		index--;

		if (index < 0)
			index += backingArray.length;
	}

	public String toString() {
		return "CircularBuffer[" + size() + "]";
	}
}
