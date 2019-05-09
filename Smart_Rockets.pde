// Modified from Shiffman's Nature of Code
// https://natureofcode.com/book/chapter-9-the-evolution-of-code/


final int LIFETIME = 300; // Hardcoded time to live

Population population; // Collection of rockets

int lifeCounter; // How many cycles have passed

PVector target; // Where the rocket is trying to go

void setup() {
	size(1200, 600);

	lifeCounter = 0;
	target = new PVector(width/2, 24);
	float mutationRate = 0.01;
	population = new Population(mutationRate, 50);
}

// Runs every frame
void draw() {
	background(42, 160, 255); // Blue
	//background(0); // Black

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
		lifeCounter = 0; // Make sure there's no overflow
		population.fitness();
		population.selection();
		population.reproduce();
	}


	// Display some debug info
	fill(0);
	textSize(30);
	text("Generation: " + population.getGenerations(), 10, 40);
	text("Cycles left: " + (LIFETIME-lifeCounter), 10, 80);

}
