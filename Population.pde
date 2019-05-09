class Population {

	float mutationRate;
	Rocket[] population;
	ArrayList<Rocket> matingPool;
	int generations;

	// Initialize the population
	Population(float m, int num) {
		mutationRate = m;
		population = new Rocket[num];
		matingPool = new ArrayList<Rocket>();
		generations = 0;

		//make a new set of rockets
		for (int i = 0; i < population.length; i++) {
			PVector position = new PVector(width/2,height+20);
			population[i] = new Rocket(position, new DNA());
		}
	}

	void live() {
		// Run all the rockets in the population
		for (int i = 0; i < population.length; i++) {
			population[i].run();
		}
	}

	// Find the fitness of the rocket
	void fitness() {
		for (int i = 0; i < population.length; i++) {
			population[i].fitness();
		}
	}

	// Generate natural selection mating pool
	void selection() {
		// Reset mating pool
		matingPool.clear();
		// Find the maximum fitness in the pool
		float maxFitness = getMaxFitness();

		for (int i = 0; i < population.length; i++) {
			float fitnessNormal = map(population[i].getFitness(),0,maxFitness,0,1);
			int n = (int) (fitnessNormal * 100);  // Arbitrary multiplier
			for (int j = 0; j < n; j++) {
				matingPool.add(population[i]);
			}
		}
	}

	// Create the next generation of rockets
	void reproduce() {
		// Go through the whole population and replace everything with the new generation
		for (int i = 0; i < population.length; i++) {
			int m = int(random(matingPool.size()));
			int d = int(random(matingPool.size()));
			Rocket mom = matingPool.get(m);
			Rocket dad = matingPool.get(d);

			DNA momgenes = mom.getDNA();
			DNA dadgenes = dad.getDNA();
			DNA child = momgenes.merge(dadgenes);
			child.mutate(mutationRate);
			PVector position = new PVector(width/2,height+20);
			population[i] = new Rocket(position, child);
		}
		generations++;
 	 }

	// Getter
	int getGenerations() {
		return generations;
	}

	// Find best fitting rocket from the population
	float getMaxFitness() {
		float record = 0;
		for (int i = 0; i < population.length; i++) {
			if(population[i].getFitness() > record) {
				record = population[i].getFitness();
			}
		}
		return record;
	}
}