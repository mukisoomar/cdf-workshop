package com.hortonworks.workshop.clickstream;

import java.nio.charset.StandardCharsets;
import java.util.*;
import java.nio.file.*;
import java.io.*;

import static java.lang.System.exit;
import static java.nio.file.Files.readAllLines;


public class GenerateClickStreamData {

    public static void main(String[] args) {

        // Filenames
        String PRODUCTS_DESCR = "products.tsv";
        String OMNITURE_DATA = "filtered-omniture-raw.tsv";


        // Usage help
        if (args.length > 0) {
            if (args[0].equals("--h")){
                System.out.println ("Usage: GenerateFile <output file name>" );
            } else {
                System.out.println ("-- Output file will be written to " + args[0]);
            }
        } else {
            System.out.println ("Usage: GenerateFile <output file name>");
        }



        // Read product file and create
        Path productsFilePath = FileSystems.getDefault().getPath("data", PRODUCTS_DESCR);
        Path omnitureFilePath = FileSystems.getDefault().getPath("data", OMNITURE_DATA);

        if (productsFilePath != null) {
            HashMap<String, Product> products = populateProducts(productsFilePath);
        } else {
            System.out.println ("The products definition file could not be found. Exiting!");
            exit(1);
        }

        if (omnitureFilePath != null) {

        }

        // Read data/omniture file, iterate over each line
        try {
            Path omnitureFilePath = FileSystems.getDefault().getPath("data", PRODUCTS_DESCR);
        } catch (Exception e) {
            System.out.println ("Main: Omniture file exception.");
            e.printStackTrace();
        }


        FileInputStream inputStream = null;
        Scanner sc = null;

        try {
            inputStream = new FileInputStream(path);
            sc = new Scanner(inputStream, "UTF-8");
            while (sc.hasNextLine()) {
                String line = sc.nextLine();
                // System.out.println(line);
            }
            // note that Scanner suppresses exceptions
            if (sc.ioException() != null) {
                throw sc.ioException();
            }
        } finally {
            if (inputStream != null) {
                inputStream.close();
            }
            if (sc != null) {
                sc.close();
            }
        }

        // define log output pattern
        // log_id|timestamp|ip_address|URL|product_id|is_purchase|is_error|time_spent


    }

    public static HashMap <String, Product> populateProducts(Path productsFilePath){

        HashMap<String,Product> products = new HashMap();

        // Read the file from the location
        String PRODUCTS_DESCR = "products.tsv";
        try {
            Path path = FileSystems.getDefault().getPath("data", PRODUCTS_DESCR);

            //System.out.println (path.toAbsolutePath());
            //BufferedReader reader = Files.newBufferedReader (path, StandardCharsets.UTF_8);

            List <String> lines = readAllLines (path, StandardCharsets.UTF_8);

            lines.forEach((line) -> {
                String[] fields = line.split("\t");
                if (fields.length == 3) {
                    Product p = new Product(fields[0], fields[1], fields[2]);
                    products.put(fields[2], p);
                }
            });

        } catch (Exception e) {
            System.out.println (e.toString());
        }

        // Test the products map
        for (Map.Entry<String, Product> entry : products.entrySet()) {
            String key = entry.getKey();
            Product product = entry.getValue();

            System.out.println("Key = " + key + ", Value = " + product.toString());
        }

        return products;
    }
}
