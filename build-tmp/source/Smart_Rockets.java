import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Smart_Rockets extends PApplet {

// Modified from Shiffman's Nature of Code
// https://natureofcode.com/book/chapter-9-the-evolution-of-code/


final int LIFETIME = 500; // Hardcoded time to live

Population population; // Collection of rockets

int lifeCounter; // How many cycles have passed

PVector target; // Where the rocket is trying to go

public void setup() {
	

	lifeCounter = 0;
	target = new PVector(width/2, 24);
	float mutationRate = 0.01f;
	population = new Population(mutationRate, 50);
}

public void draw() {
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


	// Display some debug info
	fill(0);
	text("Generation: " + population.getGenerations(), 10, 18);
	text("Cycles left: " + (LIFETIME-lifeCounter), 10, 36);

}
class DNA {
	PVector[] genes;
	float maxForce = 0.1f;

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

	public DNA merge(DNA partner) {
		// Flip a coin
		int rand = PApplet.parseInt(random(100));
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
	public void mutate(float mutation) {
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
	public void fitness() {

	}

	// Generate natural selection mating pool
	public void selection() {

	}

	// Create the next generation of rockets
	public void reproduce() {
	// Go through the whole population and replace everything with the new generation
	for (int i = 0; i < fleet.length; i++) {
		int m = PApplet.parseInt(random(matingPool.size()));
		int d = PApplet.parseInt(random(matingPool.size()));
		Rocket mom = matingPool.get(m);
		Rocket dad = matingPool.get(d);

		DNA momgenes = mom.getDNA();
		DNA dadgenes = dad.getDNA();
		DNA child = momgenes.merge(dadgenes);
		child.mutate(mutationRate);
		PVector position = new PVector(width/2,height+20);
		fleet[i] = new Rocket(position, child);
	}
	generations++;
  }

	public void live() {
		// Run all the rockets in the population
		for (int i = 0; i < fleet.length; i++) {
			fleet[i].run();
		}
	}

	// Getter
	public int getGenerations() {
		return generations;
	}
}
// Used Yong's Rocket class as base
//https://gist.github.com/ybakos/f8a88da3cf382ba707c20277aa38ef71

class Rocket {
	// Declare all variables
	PVector position;
	PVector velocity;
	PVector acceleration;
	float size;
	float fitness;
	int geneCounter = 0;
	DNA dna;
	boolean hitTarget;

	// Constructor
	Rocket(PVector location, DNA newDNA) {
		acceleration = new PVector();
		velocity = new PVector();
		position = location.get();
		size = 4;
		dna = newDNA;
	}

	public float fitness() {
		float dist = dist(position.x, position.y, target.x, target.y);
		// Return how far the end is from the goal
		return pow(1.0f / dist, 2);
	}

	public void run() {
		applyForce(dna.genes[geneCounter]);
		geneCounter++;
		update();
	}

	// Tell rocket what force to apply every frame
	public void applyForce(PVector f) {
		acceleration.add(f);
	}

	// Always telling every single rocket to update position based on velocity every single frame
	public void update() {
		velocity.add(acceleration);
		position.add(velocity);
		acceleration.mult(0); // Reset to 0 so doesn't accelerate forever
	}

	public void display() {
		float theta = velocity.heading2D() + PI/2;
		fill(100, 200);
		stroke(255); // Color of rocket
		pushMatrix(); // Keep track of state to pop later
		translate(position.x, position.y); // Move to rocket's position
		rotate(theta); // Rotate canvas to draw

		// Thrusters
		rectMode(CENTER);
		fill(0);
		rect(-size/2, size*2, size/2, size);
		rect(size/2, size*2, size/2, size);

		// Fuselage
		fill(120);
		beginShape(TRIANGLES);
		vertex(0, -size*2);
		vertex(-size, size*2);
		vertex(size, size*2);
		endShape();

		popMatrix();
	}

	// Getters
	public float getFitness() {
		return fitness;
	}
	public DNA getDNA() {
		return dna;
	}

}
  public void settings() { 	size(1200, 1200); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Smart_Rockets" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
