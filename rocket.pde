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