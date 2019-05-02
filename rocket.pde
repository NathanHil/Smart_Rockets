class DNA {
	float[] genes;

	DNA(int num) {
		genes = new float[num];
		for ( int i = 0; i < genes.length; i++) {
			genes[i] = float(1);
		}
	}
}
class Rocket {
	DNA dna;

	float maxSpeed;
	float maxForce;
	float size;
	float separationWeight;

	Vehicle() {
		DNA = new DNA(4);

		maxSpeed = dna.genes[0];
		maxForce = dna.genes[1];
		size = dna.genes[2];
		separationWeight = dna.genes[3];
	}
}