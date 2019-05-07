// Modified from Shiffman's Nature of Code
// https://natureofcode.com/book/chapter-9-the-evolution-of-code/


final int LIFETIME = 500; // Hardcoded time to live

Population population; // Collection of rockets

int lifeCounter; // How many cycles have passed

PVector target; // Where the rocket is trying to go

void setup() {
	size(1200, 1200);

	lifeCounter = 0;
	target = new PVector(width/2, 24);
	float mutationRate = 0.01;
	population = new Population(mutationRate, 50);
}

void draw() {
	background(42, 160, 255);

	// Draw the target
	fill(255);
	ellipse(target.x,target.y,24,24);

	// While the lifecycle is less than the time to live, keep going
	if (lifeCounter < LIFETIME) {
		population.live();
		lifeCounter++;
	}
	// otherwise, Star Trek Next Generation
	else {
		population.fitness();
		population.selection();
		population.reproduce();
	}

}
