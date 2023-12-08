import java.io.BufferedReader; 
import java.io.FileReader; 
import java.io.IOException; 
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Queue;

public class Main {
	private static long gcd(long a, long b) {
		while (b > 0) {
        		long temp = b;
	        	b = a % b;
        		a = temp;
    		}
    		return a;
	}

	private static long gcd(long[] input) {
		long result = input[0];
    		for(int i = 1; i < input.length; i++) result = gcd(result, input[i]);
    		return result;
	}

	private static long lcm(long a, long b) {
   		return a * (b / gcd(a, b));
	}

	private static long lcm(long[] input) {
    		long result = input[0];
    		for(int i = 1; i < input.length; i++) result = lcm(result, input[i]);
    		return result;
	}	

  	public static void main(String[] args) throws IOException {
		try(BufferedReader br = new BufferedReader(new FileReader("input.txt"))) {
			Queue<String> steps = new LinkedList<>();
			HashMap<String, ArrayList> network = new HashMap<String, ArrayList>();
			long[] total = new long[6];
			String line = br.readLine();
		        for (int i = 0; i < line.length(); i++) {
    				steps.add(String.valueOf(line.charAt(i)));
        		}	

			br.readLine(); //skip blank

    			while (line != null) {
		        	line = br.readLine();
				if (line != null) {
					String[] parts = line.split("=", 2);
					String loc = (String) parts[0].strip();
					String left = (String) parts[1].split(",", 2)[0].replace("(", "").strip();
					String right = (String) parts[1].split(",", 2)[1].replace(")", "").strip(); 
					ArrayList<String> stops = new ArrayList<String>();
					stops.add(left);
					stops.add(right);
					network.put(loc, stops);

				}
    			}
			int i = 0;
			for (var entry : network.entrySet()) {
				String k = (String) entry.getKey();
				if (k.substring(k.length() - 1).equals("A")) {
				   	int hops = 0;
					String location = k;
	                        	while (!location.substring(location.length() - 1).equals("Z")) {
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
					total[i] = hops;
					i++;
				}	
			}
			System.out.println(lcm(total));
		}
	}
}
