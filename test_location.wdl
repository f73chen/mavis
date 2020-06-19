workflow test_location {
    call find_tools
}

task find_tools {
    command {
        ls $MAVIS_ROOT
        echo "@@@@@@@@@@@@@@@@"
        ls $PYTHON_ROOT
        echo "@@@@@@@@@@@@@@@@"
        ls $BLAT_ROOT
        echo "@@@@@@@@@@@@@@@@"
        ls $CONDA_ROOT
        echo "@@@@@@@@@@@@@@@@"

        echo $PATH
        echo "################"
        echo $MANPATH
        echo "################"
        echo $LD_LIBRARY_PATH
        echo "################"
        echo $PYTHONPATH
        echo "################"
        echo $PKG_CONFIG_PATH
        echo "################"
    }
    output{
        String message = read_string(stdout())
    }
    runtime {
        docker: "g3chen/mavis:1.0"
    }
}
