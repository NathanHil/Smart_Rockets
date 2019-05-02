class DNA {
	float[] genes;

	DNA(int num) {
		genes = new float[num];
		for ( int i = 0; i < genes.length; i++) {
			genes[i] = float(1);
		}
	}
}