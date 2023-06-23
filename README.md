# Polifonia Endpoint Configuration

Configuration of endpoints for the Polifonia server, including ontology documentation, visualisation and SPARQL endpoint.

## How-to

Clone the repository with 

```
git clone git@github.com:polifonia-project/enpoint.git
```

to download the configuration template.

The template already comes with a toy example, based on the [Pizza ontology](https://github.com/owlcs/pizza-ontology).
You can directly test it out by running the commands

```
docker-compose build
docker-compose up
```

Note that you need to have `docker` and `docker-compose` installed. Follow the official guides on how to obtain [Docker](https://docs.docker.com/get-docker/) and [Compose](https://docs.docker.com/compose/install/).

Few minutes might be required in order to fetch all the required components and build the overall architecture.

When the output of the program has settles, usually when `[INFO] Started Jetty Server` appears, the whole endpoint is fully functional.
By default, the endpoint is available at [http://localhost:8080](http://localhost:8080).

An homepage with the relevant services will be shown. It is also possible to directly access each relevant service:
* open [http://localhost:8080/ontology](http://localhost:8080/ontology) to access the ontology documentation;
* open [http://localhost:8080/query](http://localhost:8080/query) to access the SPARQL endpoint;
* open [http://localhost:8080/resource/](http://localhost:8080/resource/) to access the SPARQL LODView interface, try [http://localhost:8080/resource/PizzaTopping](http://localhost:8080/resource/PizzaTopping) to access one of the resources;

### Configuration

To use your own ontology and KG, you need to delete the content of the `data/` and `ontology/` directory and replace it, respectively, with your ontology and your KG triples. You can add multiple ontologies and triples, even using a nested directory structure, the service will automatically load them in the triple store.

You can update the triple store configuration to enable reasoning profiles. To do so, open the file `docker-compose.yml` and go to line `34`.
You can comment the line `- ".docker/graphdb_confs/graphdb.none.ttl:/repository.init/db/config.ttl:ro"` by adding the symbol `#` at the top of the line and uncomment one of the 2 following lines by removing the symbol `#`. Only one line needs to be uncommented. The line are sorted by growing computational complexity: no reasoning at all, `rdfs` only profile, `OWL2 RL` profile.

Finally, you need to update the IRI of you ontology. This has to be done in the file `.docker/conf.lodview.ttl`. Go to line `60` and replace `http://w3id.org/polifonia/pizza/` with your ontology prefix.

Note that your final KG needs to follows Polifonia's conventions: the ontology prefix needs to be `https://w3id.org/polifonia/ontology/` while your resources prefix needs to be `https://w3id.org/polifonia/resource/`.

Also update the file `.docker/yasgui_index.html` by adding your endpoint name in line 54.
Also update the file `.docker/conf.lodview.ttl` by adding your endpoint name in line 54.

### Running in production

TBD

Make sure to define the port that has been assigned to your project. You can check for this by heading to To run the endpoint, use

```
docker-compose build
docker-compose up -d
```

you can stop your service with 

```
docker-compose down
```