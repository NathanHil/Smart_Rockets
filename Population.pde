class Population {

	float mutationRate;
	Rocket[] fleet;
	ArrayList<Rocket> matingPool;
	int generations;

	Population(float m, int num) {
		mutationRate = m;
		fleet = new Rocket[num];
		matingPool = new ArrayList<Rocket>();
		generations = 0;

		//make a new set of rockets
		for (int i = 0; i < fleet.length; i++) {
			PVector position = new PVector(width/2,height+20);
			fleet[i] = new Rocket(position, new DNA());
		}
	}

	// Find the fitness of the rocket
	void fitness() {

	}

	// Generate natural selection mating pool
	void selection() {

	}

	// Create the next generation of rockets
	void reproduce() {

	}

	void live() {
		// Run all the rockets in the population
		for (int i = 0; i < fleet.length; i++) {
			fleet[i].run();
		}
	}
}