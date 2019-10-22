FROM jupyter/datascience-notebook

RUN pip install pyquil

RUN printf "[Rigetti Forest]\nqpu_endpoint_address = None\nqvm_address = http://qvm:5000\ncompiler_server_address = tcp://quilc:5555" > ~/.forest_config