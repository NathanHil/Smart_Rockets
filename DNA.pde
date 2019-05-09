class DNA {
	PVector[] genes;
	float maxForce = 0.1;

	// Constructor to build default DNA
	DNA() {
		genes = new PVector[LIFETIME];
		for (int i = 0; i < genes.length; i++) {
			genes[i] = PVector.random2D();
			genes[i].mult(random(0, maxForce));
		}
	}

	// Second constructor for mutated DNA
	DNA(PVector[] newgenes) {
		genes = newgenes;
	}

	DNA merge(DNA partner) {
		// Flip a coin
		int rand = int(random(100));
		PVector[] child = new PVector[genes.length];
		// Merge on random coin flip
		for (int i = 0; i < genes.length; i++) {
			if (rand%2 == 0) {
				child[i] = genes[i];
			}
			else {
				child[i] = partner.genes[i];
			}
		}    
		DNA newgenes = new DNA(child);
		return newgenes;
	}

	// Mutate the DNA of the genes
	void mutate(float mutation) {
		for (int i = 0; i < genes.length; i++) {
			if (random(1) < mutation) {
				// New random angle
				float angle = random(TWO_PI);
				genes[i] = new PVector(cos(angle), sin(angle));
				genes[i].mult(random(0, maxForce));
			}
		}
	}
}