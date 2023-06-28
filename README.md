# Polifonia Endpoint Configuration

Configuration of endpoints for the Polifonia server, including ontology documentation, visualisation and SPARQL endpoint.

## Install the Endpoint

Clone this repository with [git](https://git-scm.com/) to download the configuration template:

```bash
git clone https://github.com/polifonia-project/endpoint <endpoint_name>
```

where `<endpoint_name>` is the name of your endpoint.
Naming the enpoint is crucial, as different endpoints will use the same template, and will be distinguished by their name.

The template includes a SPARQL endpoint, along with several tools for visualising, documenting and querting the data, including:

- [GraphDB](https://graphdb.ontotext.com/) as triple store;
- [YASGUI](https://triply.cc/docs/yasgui-api) as SPARQL query interface;
- [LODView](https://lodview.it/) as visualisation tool;
- [PyLODE](https://github.com/RDFLib/pyLODE) as ontology documentation tool.

The template already comes with a toy example, based on the [Pizza ontology](https://github.com/owlcs/pizza-ontology).

Please, note that `docker` and `docker-compose` are required to run the endpoint. Follow the official guides on how to obtain [Docker](https://docs.docker.com/get-docker/) and [Compose](https://docs.docker.com/compose/install/).

Once you have entered the directory, you can run and stop the endpoint by running a single bash command:

```bash
bash endpoint.sh [start|end] <endpoint_name> <port> <path_to_ontology> <path_to_kg>
```

where:

- `start` starts the endpoint, `end` stops it;
- `endpoint_name` is the name of the endpoint, it will be used to name the docker containers and set the endpoint URIs;
- `port` is the port that will be used to access the endpoint;
- `path_to_ontology` is the path to the ontology file;
- `path_to_kg` is the path to the KG file or directory.

If no `path_to_ontology` and `path_to_kg` are provided, the endpoint will use the toy example aformentioned.

When the output of the program has settles the whole endpoint is fully functional.
By default, the endpoint is available at [http://localhost:8080](http://localhost:8080).

An homepage with the relevant services will be shown. It is also possible to directly access each relevant service:

- open [http://localhost:8080/ontology](http://localhost:8080/ontology) to access the ontology documentation;
- open [http://localhost:8080/query](http://localhost:8080/query) to access the SPARQL endpoint;
- open [http://localhost:8080/resource/](http://localhost:8080/resource/) to access the SPARQL LODView interface, try [http://localhost:8080/resource/PizzaTopping](http://localhost:8080/resource/PizzaTopping) to access one of the resources;

### Configuration

The bash command used to start the enpoint will automatically take care of the data upload and configuration.
You can add multiple ontologies and triples, even using a nested directory structure, the service will automatically load them in the triple store.

You can update the triple store configuration to enable reasoning profiles. To do so, open the file `docker-compose.yml` and go to line `34`.
You can comment the line `- ".docker/graphdb_confs/graphdb.none.ttl:/repository.init/db/config.ttl:ro"` by adding the symbol `#` at the top of the line and uncomment one of the 2 following lines by removing the symbol `#`. Only one line needs to be uncommented. The line are sorted by growing computational complexity: no reasoning at all, `rdfs` only profile, `OWL2 RL` profile.

Finally, you need to update the IRI of you ontology. This has to be done in the file `.docker/conf.lodview.ttl`. Go to line `60` and replace `http://w3id.org/polifonia/pizza/` with your ontology prefix.

Note that your final KG needs to follows Polifonia's conventions: the ontology prefix needs to be `https://w3id.org/polifonia/ontology/` while your resources prefix needs to be `https://w3id.org/polifonia/resource/`.

Also update the file `.docker/yasgui_index.html` by adding your endpoint name in line 54.
Also update the file `.docker/conf.lodview.ttl` by adding your endpoint name in line 54.

## License

MIT License

Copyright (c) 2023 Nicolas Lazzari, Andrea Poltronieri

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
