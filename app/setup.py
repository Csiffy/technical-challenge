#!/usr/bin/python


__version__= '0.0.1'
__author__ = "Zoltan Csiffary"
__license__ = "..."
__copyright__ = """
Copyright content
"""


from setuptools import setup, find_packages

COMPANY = 'Aylien'
NAME = 'Technical challenge'
REQUIREMENTS = [
    'appdirs==1.4.3',
    'click==6.7',
    'Flask==0.12.3',
    'itsdangerous==0.24',
    'Jinja2==2.9.6',
    'MarkupSafe==1.0',
    'packaging==16.8',
    'prometheus-client==0.0.19',
    'pyparsing==2.2.0',
    'six==1.10.0',
    'Werkzeug==0.12.1'
]


setup(
    name=NAME,
    version=__version__,
    author='Zoltan Csiffary',
    author_email='info@domain.com',
    url='https://aylien.com',
    description=COMPANY + ' ' + NAME,
    install_requires=REQUIREMENTS,
    packages=find_packages()
)

