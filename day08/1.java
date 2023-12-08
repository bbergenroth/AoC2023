import java.io.BufferedReader; 
import java.io.FileReader; 
import java.io.IOException; 
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Queue;

public class Main {
  	public static void main(String[] args) throws IOException {
		try(BufferedReader br = new BufferedReader(new FileReader("input.txt"))) {
			Queue<String> steps = new LinkedList<>();
			HashMap<String, ArrayList> network = new HashMap<String, ArrayList>();
			
			String line = br.readLine();
		        for (int i = 0; i < line.length(); i++) {
    				steps.add(String.valueOf(line.charAt(i)));
        		}	

			br.readLine(); //skip blank

    			while (line != null) {
		        	line = br.readLine();
				if (line != null) {
					String[] parts = line.split("=", 2);
					String loc = (String) parts[0].strip();;
					String left = (String) parts[1].split(",", 2)[0].replace("(", "").strip();
					String right = (String) parts[1].split(",", 2)[1].replace(")", "").strip(); 
					ArrayList<String> stops = new ArrayList<String>();
					stops.add(left);
					stops.add(right);
					network.put(loc, stops);

				}
    			}
			String location = "AAA";
    			int hops = 0;

			while (!location.equals("ZZZ")) {
        			hops++;
			        String l = (String) network.get(location).get(0);
			        String r = (String) network.get(location).get(1);
				String next = (String) steps.remove();
			        if (next.equals("L")) {
			                location = l;
			        } else {
			                location = r;
			        }
			        steps.add(next);
			    }
		    System.out.println(hops);

		}
	}
}
