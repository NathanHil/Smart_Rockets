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

// Position = Where the rocket is currently
// Speed (velocity) = distance/time
// Acceleration = Speed/time
// Force = direction of acceleration
// PVector = coordinates pair from 0,0 (top right corner)

Rocket serenity;
final int LIFETIME = 100;

public void setup() {
	
	serenity = new Rocket(new PVector(200, 400));
}

public void draw() {
	background(42, 160, 255);
	serenity.update();
	serenity.display();
}

public void keyPressed() {
	if (keyCode == RIGHT) {
		serenity.applyForce(new PVector(5,0));
	}
	if (keyCode == LEFT) {
		serenity.applyForce(new PVector(-5,0));
	}
	if (keyCode == UP) {
		serenity.applyForce(new PVector(0,-5));
	}
	if (keyCode == DOWN) {
		serenity.applyForce(new PVector(0,5));
	}
}
public void keyHeld() {

}
class DNA {
	PVector[] genes;
	float maxForce = 0.1f;

	DNA() {
		genes = new PVector[LIFETIME];
		for (int i = 0; i < genes.length; i++) {
			genes[i] = PVector.random2D();
			genes[i].mult(random(0, maxForce));
		}
	}
}
// Yong's Rocket class from
//https://gist.github.com/ybakos/f8a88da3cf382ba707c20277aa38ef71

class Rocket {

	// Position = Where the rocket is currently
	// Speed (velocity) = distance/time
	// Acceleration = Speed/time
	// Force = direction of acceleration

	PVector position;
	PVector velocity;
	PVector acceleration;

	float size;

	Rocket(PVector location) {
		acceleration = new PVector();
		velocity = new PVector();
		position = location.get();
		size = 4;
	}

	// Tell rocket what force to apply every frame
	public void applyForce(PVector f) {
		acceleration.add(f);
	}

	public float fitness() {
		float distance = PVector.dist(position, target);
		// Return how far the end is from the goal
		return 1.0f / distance;
	}


	// Always telling every single rocket to update position based on velocity every single frame
	public void update() {
		velocity.add(acceleration);
		position.add(velocity);
		acceleration.mult(0); // Reset to 0 so doesn't accelerate forever
	}

	public void display() {
		float theta = velocity.heading2D() + PI/2;
		fill(200, 100);
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
